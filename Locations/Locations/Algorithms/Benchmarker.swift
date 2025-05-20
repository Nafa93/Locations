//
//  Benchmarker.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
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

final class Benchmarker {
    private let searchableDataSets: [SearchableDataSet]
    private let citiesRepository: CityRepository

    init(
        searchableDataSets: [SearchableDataSet],
        citiesRepository: CityRepository
    ) {
        self.searchableDataSets = searchableDataSets
        self.citiesRepository = citiesRepository
    }

    func startBenchmark(prefix: String, iterations: Int = 1) async throws {
        let dataSet = try await citiesRepository.getAll()

        for searchableDataSet in searchableDataSets {
            benchmark(label: "Adding to \(type(of: searchableDataSet))") {
                dataSet.forEach { searchableDataSet.insert($0) }
            }

            benchmark(label: "Searching in \(type(of: searchableDataSet))", iterations: iterations) {
                print("Found \(searchableDataSet.search(prefix: prefix).count) words with \(type(of: searchableDataSet))")
            }
        }
    }

    private func benchmark(label: String, iterations: Int = 1, _ block: () -> Void) {
        let start = CFAbsoluteTimeGetCurrent()

        for _ in 0..<iterations {
            block()
        }

        let end = CFAbsoluteTimeGetCurrent()
        let total = end - start
        print("\(label): \(total / Double(iterations)) seconds per run (\(iterations)x)")
    }
}
