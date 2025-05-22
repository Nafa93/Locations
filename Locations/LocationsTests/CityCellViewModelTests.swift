//
//  CityCellViewModelTests.swift
//  LocationsTests
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import XCTest
@testable import Locations

final class CityCellViewModelTests: XCTestCase {
    var sut: CityCellViewModel!

    override func setUpWithError() throws {
        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: { _ in },
            onCellTapped: { _ in },
            onDetailButtonTapped: { _ in }
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_title_shouldBeCityAndCountry() {
        // Given
        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: { _ in },
            onCellTapped: { _ in },
            onDetailButtonTapped: { _ in }
        )

        // When
        let title = sut.title

        // Then
        XCTAssertEqual(title, "Buenos Aires, AR")
    }

    func test_subtitle_shouldBeCoordinates() {
        // Given
        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: { _ in },
            onCellTapped: { _ in },
            onDetailButtonTapped: { _ in }
        )

        // When
        let subtitle = sut.subtitle

        // Then
        XCTAssertEqual(subtitle, "Latitude: 0.0, Longitude: 0.0")
    }

    func test_onFavoritesTapped_completionIsCalled() {
        // Given
        let expectation = expectation(description: name)

        var result: City?

        let callback: (City) -> Void = { city in
            result = city
            expectation.fulfill()
        }

        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: callback,
            onCellTapped: { _ in },
            onDetailButtonTapped: { _ in }
        )

        // When
        sut.favoriteButtonHandler()

        wait(for: [expectation])

        // Then
        XCTAssertNotNil(result)
    }

    func test_onCellTapped_completionIsCalled() {
        // Given
        let expectation = expectation(description: name)

        var result: City?

        let callback: (City) -> Void = { city in
            result = city
            expectation.fulfill()
        }

        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: { _ in },
            onCellTapped: callback,
            onDetailButtonTapped: { _ in }
        )

        // When
        sut.cellTapHandler()

        wait(for: [expectation])

        // Then
        XCTAssertNotNil(result)
    }

    func test_onDetailButtonTapped_completionIsCalled() {
        // Given
        let expectation = expectation(description: name)

        var result: City?

        let callback: (City) -> Void = { city in
            result = city
            expectation.fulfill()
        }

        sut = CityCellViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: 0.0,
                    latitude: 0.0
                )
            ),
            onFavoritesButtonTapped: { _ in },
            onCellTapped: { _ in },
            onDetailButtonTapped: callback
        )

        // When
        sut.detailButtonHandler()

        wait(for: [expectation])

        // Then
        XCTAssertNotNil(result)
    }
}
