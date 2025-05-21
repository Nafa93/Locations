//
//  TernarySearchTreeTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import XCTest
@testable import Locations

final class TernarySearchTreeTests: XCTestCase {
    var sut: TernarySearchTree!

    override func setUpWithError() throws {
        sut = TernarySearchTree()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_A_returnsFourElements() async throws {
        // Given
        let cities = mockCities()
        let prefix = "A"

        cities.forEach { sut.insert($0) }

        // When
        let result = await sut.search(prefix: prefix)

        // Then
        XCTAssertEqual(result.count, 4)
        XCTAssertTrue(cities.contains(where: { $0.name == "Alabama" } ))
        XCTAssertTrue(cities.contains(where: { $0.name == "Albuquerque" } ))
        XCTAssertTrue(cities.contains(where: { $0.name == "Anaheim" } ))
        XCTAssertTrue(cities.contains(where: { $0.name == "Arizona" } ))
    }

    func test_s_returnsOneElement() async throws {
        // Given
        let cities = mockCities()
        let prefix = "s"

        cities.forEach { sut.insert($0) }

        // When
        let result = await sut.search(prefix: prefix)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(cities.contains(where: { $0.name == "Sydney" } ))
    }

    func test_Al_returnsTwoElements() async throws {
        // Given
        let cities = mockCities()
        let prefix = "Al"

        cities.forEach { sut.insert($0) }

        // When
        let result = await sut.search(prefix: prefix)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(cities.contains(where: { $0.name == "Alabama" } ))
        XCTAssertTrue(cities.contains(where: { $0.name == "Albuquerque" } ))
    }

    func test_Alb_returnsOneElement() async throws {
        // Given
        let cities = mockCities()
        let prefix = "Alb"

        cities.forEach { sut.insert($0) }

        // When
        let result = await sut.search(prefix: prefix)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(cities.contains(where: { $0.name == "Albuquerque" } ))
    }
}

extension XCTestCase {
    func mockCities() -> [City] {
        [
            City(id: 0, country: "US", name: "Alabama", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 1, country: "US", name: "Albuquerque", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 2, country: "US", name: "Anaheim", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 3, country: "US", name: "Arizona", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 4, country: "AU", name: "Sydney", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]
    }
}
