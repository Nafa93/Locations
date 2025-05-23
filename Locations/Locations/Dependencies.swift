//
//  Dependencies.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//

import Foundation

final class Dependencies {
    static var shared = Dependencies()

    private var coreDataPersistence = CoreDataPersistence()

    private init() {}

    func isUITest() -> Bool {
        ProcessInfo.processInfo.environment["UITestMode"] == "true"
    }

    var cityRepository: CityRepository {
        if isUITest() {
            return MockCityRepository(
                cities: [
                    City(id: 0, country: "AR", name: "Buenos Aires", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
                    City(id: 1, country: "AU", name: "Sidney", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
                ],
                searchableDataSet: TernarySearchTree()
            )
        } else {
            return LocalCityRepository(
                searchableDataSet: TernarySearchTree()
            )
        }
    }

    var favoritesRepository: FavoritesRepository {
        if isUITest() {
            return MockFavoritesRepository(favoriteCities: [])
        } else {
            return LocalFavoritesRepository(coreDataPersistence: coreDataPersistence)
        }
    }
}
