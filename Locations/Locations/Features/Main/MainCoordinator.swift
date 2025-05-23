//
//  MainCoordinator.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import UIKit
import SwiftUI

final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let cityListViewModel = CityListViewModel(
            cityRepository: LocalCityRepository(
                searchableDataSet: TernarySearchTree()
            ),
            favoritesRepository: LocalFavoritesRepository(
                coreDataPersistance: CoreDataPersistence()
            )
        )
        cityListViewModel.coordinator = self
        let cityMapViewModel = CityMapViewModel()
        let mainViewModel = MainViewModel(
            cityListViewModel: cityListViewModel,
            mapViewModel: cityMapViewModel
        )
        cityListViewModel.delegate = cityMapViewModel

        let view = MainView(viewModel: mainViewModel)
        let vc = UIHostingController(rootView: view)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToMapView(_ city: City) {
        let viewModel = CityMapViewModel(
            latitude: city.coordinate.latitude,
            longitude: city.coordinate.longitude,
            distance: 10000
        )
        let view = CityMapView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToDetailView(_ city: City) {
        let viewModel = CityDetailViewModel(city: city)
        let view = CityDetailView(viewModel: viewModel)
        let vc = UIHostingController(rootView: view)
        vc.title = viewModel.title
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
}

