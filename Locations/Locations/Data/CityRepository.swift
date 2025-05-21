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

final class LocalCityRepository: CityRepository {

    private let jsonReader: JSONReader

    init(jsonReader: JSONReader = JSONReader()) {
        self.jsonReader = jsonReader
    }

    func getAll() async throws -> [City] {
        try await self.jsonReader.readFromMainBundle("cities", type: [City].self)
    }
}
