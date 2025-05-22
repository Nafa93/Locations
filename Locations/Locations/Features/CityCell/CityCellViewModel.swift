//
//  CityCellViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 21/05/2025.
//

import Foundation

@Observable final class CityCellViewModel {
    private let city: City
    private let onFavoritesButtonTapped: (City) -> Void
    private let onCellTapped: (City) -> Void
    private let onDetailButtonTapped: (City) -> Void

    init(
        city: City,
        onFavoritesButtonTapped: @escaping (City) -> Void,
        onCellTapped: @escaping (City) -> Void,
        onDetailButtonTapped: @escaping (City) -> Void
    ) {
        self.city = city
        self.onFavoritesButtonTapped = onFavoritesButtonTapped
        self.onCellTapped = onCellTapped
        self.onDetailButtonTapped = onDetailButtonTapped
    }

    var title: String {
        "\(city.name), \(city.country)"
    }

    var subtitle: String {
        "Latitude: \(city.coordinate.latitude), Longitude: \(city.coordinate.longitude)"
    }

    func favoriteButtonHandler() {
        onFavoritesButtonTapped(city)
    }

    func cellTapHandler() {
        onCellTapped(city)
    }

    func detailButtonHandler() {
        onDetailButtonTapped(city)
    }
}
