//
//  CityListViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation
import UIKit

protocol CityListViewModelDelegate: AnyObject {
    func onCitySelected(_ city: City) async -> Void
}

@Observable final class CityListViewModel {
    private let cityRepository: CityRepository
    private let favoritesRepository: FavoritesRepository
    private var allCities: [City] = []
    var favoritesCities: Set<City> = []
    var displayableCities: [City] = []
    var error: Errors?
    var isFavoritesOn = false
    var currentPrefix = ""

    weak var delegate: CityListViewModelDelegate?
    weak var coordinator: MainCoordinator?

    init(
        cityRepository: CityRepository,
        favoritesRepository: FavoritesRepository
    ) {
        self.cityRepository = cityRepository
        self.favoritesRepository = favoritesRepository
    }

    @MainActor
    private var isPortrait: Bool {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let orientation = scene.interfaceOrientation

            return orientation.isPortrait
        } else {
            return true
        }
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

        // TODO: Split into functions
        guard prefix != "" else {
            if isFavoritesOn {
                displayableCities = Array(favoritesCities)
            } else {
                displayableCities = allCities
            }
            return
        }

        // TODO: Move sorting to repo because ternary doesn't need it
        let sortedCities = sortCities(await cityRepository.search(prefix: prefix))

        if isFavoritesOn {
            let filteredFavorites = sortedCities.filter { favoritesCities.contains($0) }
            displayableCities = filteredFavorites
        } else {
            displayableCities = sortedCities
        }
    }

    @MainActor
    func upsertFavorite(_ city: City) async {
        if isFavorite(city) {
            await removeFromFavorites(city)
        } else {
            await addToFavorites(city)
        }

        await searchPrefix(currentPrefix)
    }

    private func addToFavorites(_ city: City) async {
        do {
            try await favoritesRepository.addCity(city)
            favoritesCities.insert(city)
        } catch {
            self.error = .failedToAddToFavorites
        }
    }

    private func removeFromFavorites(_ city: City) async {
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

    @MainActor
    func onCellTapped(_ city: City) async {
        if isPortrait {
            coordinator?.goToMapView(city)
        } else {
            await delegate?.onCitySelected(city)
        }
    }

    func onDetailTapped(_ city: City) {
        coordinator?.goToDetailView(city)
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
