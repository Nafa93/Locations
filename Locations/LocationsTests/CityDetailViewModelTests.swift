//
//  CityDetailViewModelTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//

import XCTest
@testable import Locations

final class CityDetailViewModelTests: XCTestCase {
    var sut: CityDetailViewModel!

    override func setUpWithError() throws {
        sut = CityDetailViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            )
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_latitude_isCityCoordinateLatitude() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let latitude = sut.latitude

        // Then
        XCTAssertEqual(latitude, city.coordinate.latitude)
    }

    func test_longitude_isCityCoordinateLongitude() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let longitude = sut.longitude

        // Then
        XCTAssertEqual(longitude, city.coordinate.longitude)
    }

    func test_title_isCityName() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let title = sut.title

        // Then
        XCTAssertEqual(title, city.name)
    }

    func test_countryName_isDisplayedFullBasedOnCountryCode() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let countryName = sut.countryName

        // Then
        XCTAssertEqual(countryName, "Argentina")
    }

    func test_countryFlag_isCountryFlagEmoji() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let countryFlag = sut.countryFlag

        // Then
        XCTAssertEqual(countryFlag, "🇦🇷")
    }

    func test_hemisphereIsNorthern_ifLatitudeIsGreaterThanZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 10.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Northern"))
    }

    func test_hemisphereIsSouthern_ifLatitudeIsLessThanZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: -10.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Southern"))
    }

    func test_hemisphereIsEquator_ifLatitudeIsEqualToZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Equator"))
    }

    func test_hemisphereIsEastern_ifLongitudeIsGreaterThanZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 10.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Eastern"))
    }

    func test_hemisphereIsWestern_ifLongitudeIsLessThanZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: -10.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Western"))
    }

    func test_hemisphereIsPrimeMeridian_ifLongitudeIsEqualToZero() {
        // Given
        let city = City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        sut = CityDetailViewModel(city: city)

        // When
        let hemispheres = sut.hemispheres

        // Then
        XCTAssertTrue(hemispheres.contains("Prime Meridian"))
    }
}
