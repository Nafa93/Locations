//
//  BinarySearchDataSet.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

final class BinarySearchDataSet: SearchableDataSet {
    private var cities: [City] = []

    func insert(_ city: City) {
        cities.append(city)
    }

    func search(prefix: String) -> [City] {
        let sortedCities = cities.sorted { $0.name.lowercased() < $1.name.lowercased() }
        let lowercasedPrefix = prefix.lowercased()

        var result: [City] = []
        for city in sortedCities {
            let lowercaseCityName = city.name.lowercased()
            if lowercaseCityName.hasPrefix(lowercasedPrefix) {
                result.append(city)
            } else if !result.isEmpty {
                break
            }
        }
        return result
    }
}
