//
//  CityMapViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

@Observable final class CityMapViewModel {
    private static var defaultCoordinate = CLLocationCoordinate2D(
        latitude: -34.5875395,
        longitude: -58.4261227
    )

    var position: MapCameraPosition

    init(
        latitude: Double = CityMapViewModel.defaultCoordinate.latitude,
        longitude: Double = CityMapViewModel.defaultCoordinate.longitude,
        distance: Double = 1000
    ) {
        self.position = .camera(
            MapCamera(
                centerCoordinate: CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                ),
                distance: distance
            )
        )
    }
// TODO: Add Marker
    @MainActor
    func onCityTapped(_ city: City) -> Void {
        self.position = .camera(
            MapCamera(
                centerCoordinate: CLLocationCoordinate2D(
                    latitude: city.coordinate.latitude,
                    longitude: city.coordinate.longitude
                ),
                distance: 10000
            )
        )
    }
}

extension CityMapViewModel: CityListViewModelDelegate {
    func onCitySelected(_ city: City) async {
        Task {
            await onCityTapped(city)
        }
    }
}
