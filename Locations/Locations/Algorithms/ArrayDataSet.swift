//
//  ArrayDataSet.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

final class ArrayDataSet: SearchableDataSet {
    private var cities: [City] = []

    func insert(_ city: City) {
        cities.append(city)
    }

    func search(prefix: String) -> [City] {
        cities.filter { $0.name.lowercased().hasPrefix(prefix) }
    }
}
