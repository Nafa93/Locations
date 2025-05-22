//
//  CoreDataPersistence.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import CoreData

struct CoreDataPersistence {
    @MainActor
    static let preview: CoreDataPersistence = {
        let result = CoreDataPersistence(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = CityDataModel(
                City(
                    id: index,
                    country: "AR",
                    name: "City #\(index)",
                    coordinate: Coordinate(
                        longitude: 0.0,
                        latitude: 0.0
                    )
                ),
                context: viewContext
            )
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Locations")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func insert(_ object: NSManagedObject) async throws {
        try await withCheckedThrowingContinuation { continuation in
            container.viewContext.insert(object)

            do {
                try container.viewContext.save()
                continuation.resume()
            } catch {
                continuation.resume(throwing: Errors.failedToSaveContext)
            }
        }
    }

    func delete(_ object: NSManagedObject) async throws {
        try await withCheckedThrowingContinuation { continuation in
            container.viewContext.delete(object)

            do {
                try container.viewContext.save()
                continuation.resume()
            } catch {
                continuation.resume(throwing: Errors.failedToSaveContext)
            }
        }
    }

    func getAll<T: NSManagedObject>() async throws -> [T] {
        try await withCheckedThrowingContinuation { continuation in
            let fetchRequest = T.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false

            guard let typedRequest = fetchRequest as? NSFetchRequest<T> else {
                continuation.resume(throwing: Errors.unableToParseRequestType)
                return
            }

            do {
                let results = try container.viewContext.fetch(typedRequest)
                continuation.resume(returning: results)
            } catch {
                continuation.resume(throwing: Errors.unableToFetchItems)
            }
        }
    }
}

extension CoreDataPersistence {
    enum Errors: Error {
        case unableToParseRequestType, unableToFetchItems, failedToSaveContext
    }
}
