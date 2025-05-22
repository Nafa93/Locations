//
//  CityMapViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import Foundation
import MapKit

@Observable final class CityMapViewModel {
    private static var defaultCoordinate = CLLocationCoordinate2D(
        latitude: -34.6274385,
        longitude: -58.6060926
    )

    private static var defaultSpan = MKCoordinateSpan(
        latitudeDelta: 0.05,
        longitudeDelta: 0.05
    )

    var region = MKCoordinateRegion(
        center: CityMapViewModel.defaultCoordinate,
        span: CityMapViewModel.defaultSpan
    )

    init(
        latitude: Double = CityMapViewModel.defaultCoordinate.latitude,
        longitude: Double = CityMapViewModel.defaultCoordinate.longitude
    ) {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            span: CityMapViewModel.defaultSpan
        )
    }

    @MainActor
    func onCityTapped(_ city: City) -> Void {
        self.region.center = CLLocationCoordinate2D(
            latitude: city.coordinate.latitude,
            longitude: city.coordinate.longitude
        )
    }
}
