//
//  ArrayDataSetTests.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 20/05/2025.
//

import XCTest
@testable import Locations

final class ArrayDataSetTests: XCTestCase {
    var sut: ArrayDataSet!

    override func setUpWithError() throws {
        sut = ArrayDataSet()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_A_returnsFourElements() async throws {
        // Given
        let cities = mockCities()
        let prefix = "A"

        sut.insert(cities)

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

        sut.insert(cities)

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

        sut.insert(cities)

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

        sut.insert(cities)

        // When
        let result = await sut.search(prefix: prefix)

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(cities.contains(where: { $0.name == "Albuquerque" } ))
    }
}
