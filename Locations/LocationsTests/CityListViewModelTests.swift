//
//  CityListViewModelTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import XCTest
@testable import Locations

final class CityListViewModelTests: XCTestCase {
    var sut: CityListViewModel!
    var cityRepository: MockCityRepository!

    override func setUpWithError() throws {
        cityRepository = MockCityRepository(cities: mockCities())

        sut = CityListViewModel(cityRepository: cityRepository, searchableDataSet: TernarySearchTree())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_loadCities_populatesCitiesFromRepository() async {
        // Given
        let mockCities = mockCities()

        // When
        await sut.loadCities()

        // Then
        XCTAssertEqual(sut.allCities, mockCities)
        XCTAssertEqual(sut.displayedCities, mockCities)
    }

    func test_loadCities_whenRepositoryThrows_errorIsAssigned() async {
        // Given
        cityRepository.shouldThrow = true

        // When
        await sut.loadCities()

        // Then
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error?.localizedDescription, "Failed to load cities")
    }

    func test_searchPrefix_returnsCitiesOrderedAlphabeticallyByName_andCountry() async throws {
        // Given
        let cities = [
            City(id: 0, country: "D", name: "SidneyA", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 1, country: "C", name: "SidneyG", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 2, country: "A", name: "SidneyA", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 3, country: "C", name: "SidneyC", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 3, country: "A", name: "Another Country", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
        ]
        let prefix = "Sid"
        cityRepository.cities = cities

        // When
        await sut.loadCities()
        await sut.searchPrefix(prefix)

        // Then
        XCTAssertEqual(sut.displayedCities.count, 4)
        XCTAssertEqual(sut.displayedCities[0], cities[2])
        XCTAssertEqual(sut.displayedCities[1], cities[0])
        XCTAssertEqual(sut.displayedCities[2], cities[3])
        XCTAssertEqual(sut.displayedCities[3], cities[1])
    }

}
