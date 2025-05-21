//
//  CityRepository.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation

protocol CityRepository {
    func getAll()  async throws -> [City]
    func search(prefix: String) async -> [City]
}

final class MockCityRepository: CityRepository {
    private let searchableDataSet: SearchableDataSet

    var cities: [City]
    var shouldThrow: Bool = false

    init(cities: [City], searchableDataSet: SearchableDataSet) {
        self.cities = cities
        self.searchableDataSet = searchableDataSet
    }

    func getAll() async throws -> [City] {
        searchableDataSet.insert(cities)

        if shouldThrow {
            throw Errors.mock
        } else {
            return cities
        }
    }

    func search(prefix: String) async -> [City] {
        await searchableDataSet.search(prefix: prefix)
    }
}

extension MockCityRepository {
    enum Errors: Error {
        case mock
    }
}

final class LocalCityRepository: CityRepository {

    private let searchableDataSet: SearchableDataSet
    private let jsonReader: JSONReader
    private var cachedCities: [City] = []

    init(
        jsonReader: JSONReader = JSONReader(),
        searchableDataSet: SearchableDataSet
    ) {
        self.jsonReader = jsonReader
        self.searchableDataSet = searchableDataSet
    }

    func getAll() async throws -> [City] {
        guard cachedCities.isEmpty else { return cachedCities }

        let cities = try await self.jsonReader.readFromMainBundle("cities", type: [City].self)

        searchableDataSet.insert(cities)

        cachedCities = cities

        return cachedCities
    }

    func search(prefix: String) async -> [City] {
        await searchableDataSet.search(prefix: prefix)
    }
}
