//
//  CityListViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation

@Observable final class CityListViewModel {
    private let cityRepository: CityRepository
    private let favoritesRepository: FavoritesRepository
    private var allCities: [City] = []
    private var favoritesCities: Set<City> = []
    var displayableCities: [City] = []
    var error: Errors?
    var isFavoritesOn = false

    init(
        cityRepository: CityRepository,
        favoritesRepository: FavoritesRepository
    ) {
        self.cityRepository = cityRepository
        self.favoritesRepository = favoritesRepository
    }

    @MainActor
    func loadCities() async {
        do {
            let sortedCities = sortCities(try await self.cityRepository.getAll())
            allCities = sortedCities
            displayableCities = sortedCities
        } catch {
            self.error = .failedToLoad
        }
    }

    @MainActor
    func loadFavorites() async {
        favoritesCities = Set(await favoritesRepository.getAll())
    }

    @MainActor
    func searchPrefix(_ prefix: String) async {
        let sortedCities = sortCities(await cityRepository.search(prefix: prefix))

        if isFavoritesOn {
            let filteredFavorites = sortedCities.filter { favoritesCities.contains($0) }
            displayableCities = filteredFavorites
        } else {
            displayableCities = sortedCities
        }
    }

    @MainActor
    func toggleFavorites() {
        isFavoritesOn.toggle()
    }

    func isFavorite(_ city: City) -> Bool {
        return favoritesCities.contains(city)
    }

    private func sortCities(_ cities: [City]) -> [City] {
        cities.sorted(by: { ($0.name, $0.country) < ($1.name, $1.country) })
    }
}

extension CityListViewModel {
    enum Errors: Error, LocalizedError {
        case failedToLoad

        var errorDescription: String? {
            switch self {
                case .failedToLoad:
                    "Failed to load cities"
            }
        }
    }
}
