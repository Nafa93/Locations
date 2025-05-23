//
//  MainView.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import SwiftUI

struct MainView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var isPortrait: Bool {
        verticalSizeClass == .regular
    }

    var body: some View {
        GeometryReader { geometryReader in
            VStack {
                if viewModel.isLoading {
                    SplashView(title: viewModel.title)
                } else {
                    if isPortrait {
                        CityListView(viewModel: viewModel.cityListViewModel)
                    } else {
                        HStack(spacing: 0) {
                            CityListView(viewModel: viewModel.cityListViewModel)
                                .frame(width: geometryReader.size.width * 0.4)

                            CityMapView(viewModel: viewModel.mapViewModel)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.bootstrap()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashView: View {
    var title: String

    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)

            ProgressView()
        }
    }
}

#Preview {
    MainView(
        viewModel: MainViewModel(
            cityListViewModel: CityListViewModel(
                cityRepository: LocalCityRepository(
                    searchableDataSet: TernarySearchTree()
                ),
                favoritesRepository: MockFavoritesRepository(
                    favoriteCities: []
                )
            ),
            mapViewModel: CityMapViewModel()
        )
    )
}
