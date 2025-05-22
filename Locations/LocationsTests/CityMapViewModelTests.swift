//
//  CityMapViewModelTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import XCTest
import MapKit
@testable import Locations

final class CityMapViewModelTests: XCTestCase {
    private var sut: CityMapViewModel!

    override func setUpWithError() throws {
        sut = CityMapViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_locationChanges_onCityReceived() async {
        // Given
        let city = City(id: 0, country: "AR", name: "Buenos Aires", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))

        // When
        await sut.onCityTapped(city)

        // Then
        XCTAssertEqual(sut.region.center.latitude, city.coordinate.latitude)
        XCTAssertEqual(sut.region.center.longitude, city.coordinate.longitude)
    }
}
