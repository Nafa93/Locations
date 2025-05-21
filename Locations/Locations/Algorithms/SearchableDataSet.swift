//
//  SearchableDataSet.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

protocol SearchableDataSet {
    func insert(_ city: City)
    func search(prefix: String) async -> [City]
}
