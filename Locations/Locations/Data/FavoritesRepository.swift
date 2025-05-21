//
//  FavoritesRepository.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import Foundation

protocol FavoritesRepository {
    func getAll() async -> [City]
}

final class MockFavoritesRepository: FavoritesRepository {
    var favoriteCities: [City]

    init(favoriteCities: [City]) {
        self.favoriteCities = favoriteCities
    }

    func getAll() async -> [City] {
        return favoriteCities
    }
}
