//
//  Persistence.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import CoreData

struct CoreDataPersistance {
    @MainActor
    static let preview: CoreDataPersistance = {
        let result = CoreDataPersistance(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
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

extension CoreDataPersistance {
    enum Errors: Error {
        case unableToParseRequestType, unableToFetchItems, failedToSaveContext
    }
}
