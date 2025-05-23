//
//  CityDetailViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import Foundation

@Observable final class CityDetailViewModel {
    private var city: City

    init(city: City) {
        self.city = city
    }

    var title: String {
        city.name
    }

    var latitude: Double {
        city.coordinate.latitude
    }

    var longitude: Double {
        city.coordinate.longitude
    }

    var countryName: String {
        let locale = Locale(identifier: Locale.current.identifier)
        return locale.localizedString(forRegionCode: city.country.uppercased()) ?? "Unknown"
    }

    var countryFlag: String {
        let base: UInt32 = 127397
        var flag = ""
        for scalar in city.country.uppercased().unicodeScalars {
            if let scalar = UnicodeScalar(base + scalar.value) {
                flag.unicodeScalars.append(scalar)
            }
        }
        return flag
    }

    var hemispheres: String {
        let ns = latitude > 0 ? "Northern" : (latitude < 0 ? "Southern" : "Equator")
        let ew = longitude > 0 ? "Eastern" : (longitude < 0 ? "Western" : "Prime Meridian")
        return [ns, ew].joined(separator: ", ")
    }
}
