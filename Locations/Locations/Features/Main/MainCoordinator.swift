//
//  MainCoordinator.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import UIKit
import SwiftUI

final class MainCoordinator {
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
        let cityMapViewModel = CityMapViewModel()
        let mainViewModel = MainViewModel(
            cityListViewModel: cityListViewModel,
            mapViewModel: cityMapViewModel
        )

        let view = MainView(viewModel: mainViewModel)
        let vc = UIHostingController(rootView: view)
        // TODO: Hide navigation bar
        navigationController.pushViewController(vc, animated: true)
    }
}
