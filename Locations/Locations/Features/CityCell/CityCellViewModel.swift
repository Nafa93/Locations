//
//  CityCellViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import Foundation
import SwiftUI

@Observable final class CityCellViewModel {
    private let city: City
    private let onFavoritesButtonTapped: (City) -> Void
    private let onCellTapped: (City) -> Void
    private let onDetailButtonTapped: (City) -> Void

    var isFavorite: Bool

    init(
        city: City,
        isFavorite: Bool,
        onFavoritesButtonTapped: @escaping (City) -> Void,
        onCellTapped: @escaping (City) -> Void,
        onDetailButtonTapped: @escaping (City) -> Void
    ) {
        self.city = city
        self.isFavorite = isFavorite
        self.onFavoritesButtonTapped = onFavoritesButtonTapped
        self.onCellTapped = onCellTapped
        self.onDetailButtonTapped = onDetailButtonTapped
    }

    var title: String {
        "\(city.name), \(city.country)"
    }

    var latitudeSubtitle: String {
        "Latitude: \(city.coordinate.latitude)"
    }

    var longitudeSubtitle: String {
        "Longitude: \(city.coordinate.longitude)"
    }

    var favoriteImageName: String {
        isFavorite ? "star.fill" : "star"
    }

    var favoriteStarColor: Color {
        isFavorite ? .white : .yellow
    }

    var favoriteBackgroundColor: Color {
        isFavorite ? .yellow : .white
    }

    func favoriteButtonHandler() {
        isFavorite = !isFavorite
        onFavoritesButtonTapped(city)
    }

    func cellTapHandler() {
        onCellTapped(city)
    }

    func detailButtonHandler() {
        onDetailButtonTapped(city)
    }
}
