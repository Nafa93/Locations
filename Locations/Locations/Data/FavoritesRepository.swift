//
//  FavoritesRepository.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import Foundation
import CoreData

protocol FavoritesRepository {
    func getAll() async throws -> [City]
    func addCity(_ city: City) async throws
    func removeCity(_ city: City) async throws
}

final class MockFavoritesRepository: FavoritesRepository {
    var favoriteCities: [City]

    init(favoriteCities: [City]) {
        self.favoriteCities = favoriteCities
    }

    func getAll() async throws -> [City] {
        return favoriteCities
    }

    func addCity(_ city: City) async throws {
        self.favoriteCities.append(city)
    }

    func removeCity(_ city: City) async throws {
        self.favoriteCities.removeAll(where: { $0.id == city.id })
    }
}

final class LocalFavoritesRepository: FavoritesRepository {
    let coreDataPersistance: CoreDataPersistence

    init(coreDataPersistance: CoreDataPersistence) {
        self.coreDataPersistance = coreDataPersistance
    }

    func getAll() async throws -> [City] {
        let results: [CityDataModel]  = try await coreDataPersistance.getAll()
        return results.map { City(model: $0) }
    }
    
    func addCity(_ city: City) async throws {
        let cityDataModel = CityDataModel(city, context: coreDataPersistance.container.viewContext)

        try await coreDataPersistance.insert(cityDataModel)
    }
    
    func removeCity(_ city: City) async throws {
        let cityDataModel = CityDataModel(city, context: coreDataPersistance.container.viewContext)

        try await coreDataPersistance.delete(cityDataModel)
    }
}

extension CityDataModel {
    convenience init(_ city: City, context: NSManagedObjectContext) {
        self.init(context: context)

        self.id = Int64(city.id)
        self.country = city.country
        self.name = city.name
        self.latitude = city.coordinate.latitude
        self.longitude = city.coordinate.longitude
    }
}
