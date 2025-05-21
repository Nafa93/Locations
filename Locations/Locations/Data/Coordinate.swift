//
//  Coordinate.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import Foundation

struct Coordinate: Codable, Equatable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
