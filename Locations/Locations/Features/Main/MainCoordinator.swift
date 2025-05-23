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
        print("Nafa ", Dependencies.shared.isUITest())
    }

    func start() {
        let cityListViewModel = CityListViewModel(
            cityRepository: Dependencies.shared.cityRepository,
            favoritesRepository: Dependencies.shared.favoritesRepository
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
        let vc = MapViewController(rootView: view)
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToDetailView(_ city: City) {
        let viewModel = CityDetailViewModel(city: city)
        let view = CityDetailView(viewModel: viewModel)
        let vc = DetailViewController(rootView: view)
        vc.title = viewModel.title
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
}

final class DetailViewController: UIHostingController<CityDetailView> {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

final class MapViewController: UIHostingController<CityMapView> {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
