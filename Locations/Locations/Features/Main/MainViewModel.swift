//
//  MainViewModel.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import Foundation

@Observable final class MainViewModel {
    var cityListViewModel: CityListViewModel
    var mapViewModel: CityMapViewModel

    var title: String {
        "Locations".uppercased()
    }

    var isLoading = true

    var isSideListVisible = true

    init(cityListViewModel: CityListViewModel, mapViewModel: CityMapViewModel) {
        self.cityListViewModel = cityListViewModel
        self.mapViewModel = mapViewModel
    }

    @MainActor
    func bootstrap() async {
        defer { isLoading = false }

        guard cityListViewModel.displayableCities.isEmpty else { return }

        isLoading = true

        await cityListViewModel.loadCities()

        await cityListViewModel.loadFavorites()
    }

    @MainActor
    func toggleSideList() {
        isSideListVisible.toggle()
    }
}
