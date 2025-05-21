//
//  ArrayDataSet.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

final class ArrayDataSet: SearchableDataSet {
    private var cities: [City] = []

    func insert(_ cities: [City]) {
        cities.forEach { insert($0) }
    }

    private func insert(_ city: City) {
        cities.append(city)
    }

    func search(prefix: String) async -> [City] {
        await withCheckedContinuation { continuation in
            let result = cities.filter { $0.name.lowercased().hasPrefix(prefix.lowercased()) }
            continuation.resume(returning: result)
        }
    }
}
