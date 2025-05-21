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
    var favoritesRepository: MockFavoritesRepository!

    override func setUpWithError() throws {
        cityRepository = MockCityRepository(
            cities: mockCities(),
            searchableDataSet: TernarySearchTree()
        )

        favoritesRepository = MockFavoritesRepository(favoriteCities: [])

        sut = CityListViewModel(
            cityRepository: cityRepository,
            favoritesRepository: favoritesRepository
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        cityRepository = nil
        favoritesRepository = nil
    }

    func test_loadCities_populatesCitiesFromRepository() async {
        // Given
        let mockCities = mockCities()

        // When
        await sut.loadCities()

        // Then
        XCTAssertEqual(sut.displayableCities, mockCities)
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
            City(id: 3, country: "A", name: "Another Country", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]
        let prefix = "Sid"
        cityRepository.cities = cities

        // When
        await sut.loadCities()
        await sut.searchPrefix(prefix)

        // Then
        XCTAssertEqual(sut.displayableCities.count, 4)
        XCTAssertEqual(sut.displayableCities[0], cities[2])
        XCTAssertEqual(sut.displayableCities[1], cities[0])
        XCTAssertEqual(sut.displayableCities[2], cities[3])
        XCTAssertEqual(sut.displayableCities[3], cities[1])
    }

    func test_favouritesFilterTurnsTrue_whenCurrentStateIsFalse_andFavouritesToggleIsTriggered() async {
        // Given
        sut.isFavoritesOn = false

        // When
        await sut.toggleFavorites()

        //
        XCTAssertTrue(sut.isFavoritesOn)
    }

    func test_favouritesFilterTurnsFalse_whenCurrentStateIsTrue_andFavouritesToggleIsTriggered() async {
        // Given
        sut.isFavoritesOn = true

        // When
        await sut.toggleFavorites()

        //
        XCTAssertFalse(sut.isFavoritesOn)
    }

    func test_whenCityIsNotPartOfFavoritesRepository_cityShouldNotBeFavorite() async {
        let nonFavoriteCity = City(
            id: 0,
            country: "D",
            name: "SidneyA",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        cityRepository.cities = [nonFavoriteCity]

        // When
        await sut.loadCities()
        await sut.loadFavorites()

        // Then
        XCTAssertFalse(sut.isFavorite(nonFavoriteCity))
    }

    func test_whenCityIsPartOfFavoritesRepository_cityShouldBeFavorite() async {
        let favoriteCity = City(
            id: 0,
            country: "D",
            name: "SidneyA",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        )

        favoritesRepository.favoriteCities = [favoriteCity]
        cityRepository.cities = [favoriteCity]

        // When
        await sut.loadCities()
        await sut.loadFavorites()

        // Then
        XCTAssertTrue(sut.isFavorite(favoriteCity))
    }

    func test_whenFavoritesIsOn_displayedCitiesShouldOnlyBeFavorites() async {
        // Given
        let prefix = "A"

        let favoriteCities = [
            City(id: 0, country: "AR", name: "A city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 1, country: "AR", name: "Another City", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]

        let nonFavoriteCities = [
            City(id: 2, country: "AR", name: "A single city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 3, country: "AR", name: "Another single city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]

        cityRepository.cities = favoriteCities + nonFavoriteCities
        favoritesRepository.favoriteCities = favoriteCities

        sut.isFavoritesOn = true

        // When
        await sut.loadCities()
        await sut.loadFavorites()
        await sut.searchPrefix(prefix)

        // Then
        XCTAssertFalse(sut.displayableCities.isEmpty)

        sut.displayableCities.forEach { city in
            XCTAssertTrue(sut.isFavorite(city))
        }
    }

    func test_whenFavoritesIsOff_displayedCitiesShouldBeBothFavorite_andNonFavorite() async {
        // Given
        let prefix = "A"

        let favoriteCities = [
            City(id: 0, country: "AR", name: "A city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 1, country: "AR", name: "Another City", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]

        let nonFavoriteCities = [
            City(id: 2, country: "AR", name: "A single city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0)),
            City(id: 3, country: "AR", name: "Another single city", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
        ]

        cityRepository.cities = favoriteCities + nonFavoriteCities
        favoritesRepository.favoriteCities = favoriteCities

        sut.isFavoritesOn = false

        // When
        await sut.loadCities()
        await sut.loadFavorites()
        await sut.searchPrefix(prefix)

        // Then
        XCTAssertFalse(sut.displayableCities.isEmpty)
        XCTAssertEqual(sut.displayableCities.count, 4)
    }
}
