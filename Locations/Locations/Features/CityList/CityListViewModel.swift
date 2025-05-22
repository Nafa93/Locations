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
    var currentPrefix = ""

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
            self.error = .failedToLoadCities
        }
    }

    @MainActor
    func loadFavorites() async {
        do {
            favoritesCities = Set(try await favoritesRepository.getAll())
        } catch {
            self.error = .failedToAddToFavorites
        }
    }

    @MainActor
    func searchPrefix(_ prefix: String) async {
        currentPrefix = prefix

        guard prefix != "" else {
            displayableCities = allCities
            return
        }

        let sortedCities = sortCities(await cityRepository.search(prefix: prefix))

        if isFavoritesOn {
            let filteredFavorites = sortedCities.filter { favoritesCities.contains($0) }
            displayableCities = filteredFavorites
        } else {
            displayableCities = sortedCities
        }
    }

    @MainActor
    func toggleFavorites() async {
        isFavoritesOn.toggle()

        await searchPrefix(currentPrefix)
    }

    @MainActor
    func addToFavorites(_ city: City) async {
        do {
            try await favoritesRepository.addCity(city)
            favoritesCities.insert(city)
        } catch {
            self.error = .failedToAddToFavorites
        }
    }

    @MainActor
    func removeFromFavorites(_ city: City) async {
        do {
            try await favoritesRepository.removeCity(city)
            favoritesCities.remove(city)
        } catch {
            self.error = .failedToRemoveFromFavorites
        }
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
        case failedToLoadCities,
             failedToLoadFavorites,
             failedToAddToFavorites,
             failedToRemoveFromFavorites

        var errorDescription: String? {
            switch self {
                case .failedToLoadCities:
                    "Failed to load cities"
                case .failedToLoadFavorites:
                    "Failed to load favorite cities"
                case .failedToAddToFavorites:
                    "Failed to add city to favorites"
                case .failedToRemoveFromFavorites:
                    "Failed to remove city from favorites"
            }
        }
    }
}
