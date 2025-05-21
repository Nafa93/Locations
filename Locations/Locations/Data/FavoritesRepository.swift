//
//  FavoritesRepository.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import Foundation

protocol FavoritesRepository {
    func getAll() async -> [City]
    func addCity(_ city: City) async
    func removeCity(_ city: City) async
}

final class MockFavoritesRepository: FavoritesRepository {
    var favoriteCities: [City]

    init(favoriteCities: [City]) {
        self.favoriteCities = favoriteCities
    }

    func getAll() async -> [City] {
        return favoriteCities
    }

    func addCity(_ city: City) async {
        self.favoriteCities.append(city)
    }

    func removeCity(_ city: City) async {
        self.favoriteCities.removeAll(where: { $0.id == city.id })
    }
}
