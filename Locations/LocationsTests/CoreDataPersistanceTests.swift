//
//  CoreDataPersistanceTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import XCTest
@testable import Locations

final class CoreDataPersistanceTests: XCTestCase {
    var sut: CoreDataPersistence!

    override func setUpWithError() throws {
        sut = CoreDataPersistence(inMemory: true)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_whenAddingAnItem_getAllReturnsItem() async throws {
        // Given
        let cityDataModel = CityDataModel(
            City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            context: sut.container.viewContext
        )

        // When
        try await sut.insert(cityDataModel)

        // Then
        let allItems: [CityDataModel] = try await sut.getAll()
        XCTAssertEqual(allItems.count, 1)
        XCTAssertTrue(allItems.contains(cityDataModel))
    }

    func test_whenRemovingAnItem_getAllResultDoesNotContainItem() async throws {
        // Given
        let cityDataModel = CityDataModel(
            City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            context: sut.container.viewContext
        )

        // When
        try await sut.insert(cityDataModel)
        try await sut.delete(cityDataModel)

        // Then
        let allItems: [CityDataModel] = try await sut.getAll()
        XCTAssertEqual(allItems.count, 0)
        XCTAssertFalse(allItems.contains(cityDataModel))
    }
}
