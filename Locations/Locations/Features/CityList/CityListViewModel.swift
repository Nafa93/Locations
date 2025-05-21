//
//  CityListViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation

@Observable final class CityListViewModel {
    private let cityRepository: CityRepository
    private let searchableDataSet: SearchableDataSet

    var allCities: [City] = []
    var displayedCities: [City] = []
    var error: Errors?

    init(cityRepository: CityRepository, searchableDataSet: SearchableDataSet) {
        self.cityRepository = cityRepository
        self.searchableDataSet = searchableDataSet
    }

    @MainActor
    func loadCities() async {
        do {
            allCities = sortCities(try await self.cityRepository.getAll())
            displayedCities = allCities

            allCities.forEach { searchableDataSet.insert($0) }
        } catch {
            self.error = .failedToLoad
        }
    }

    @MainActor
    func searchPrefix(_ prefix: String) async {
        let result = await searchableDataSet.search(prefix: prefix)
        displayedCities = sortCities(result)
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
