//
//  CityRepository.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation

protocol CityRepository {
    func getAll()  async throws -> [City]
}

final class MockCityRepository: CityRepository {
    var cities: [City]
    var shouldThrow: Bool = false

    init(cities: [City]) {
        self.cities = cities
    }

    func getAll() async throws -> [City] {
        if shouldThrow {
            throw Errors.mock
        } else {
            return cities
        }
    }
}

extension MockCityRepository {
    enum Errors: Error {
        case mock
    }
}

final class LocalCityRepository: CityRepository {

    private let jsonReader: JSONReader

    init(jsonReader: JSONReader = JSONReader()) {
        self.jsonReader = jsonReader
    }

    func getAll() async throws -> [City] {
        try await self.jsonReader.readFromMainBundle("cities", type: [City].self)
    }
}
