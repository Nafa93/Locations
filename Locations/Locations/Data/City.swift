//
//  City.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 19/05/2025.
//

import Foundation

struct City: Codable, Equatable, Hashable, Identifiable {
    let id: Int
    let country: String
    let name: String
    let coordinate: Coordinate

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case country
        case name
        case coordinate = "coord"
    }

    init(id: Int, country: String, name: String, coordinate: Coordinate) {
        self.id = id
        self.country = country
        self.name = name
        self.coordinate = coordinate
    }
}
