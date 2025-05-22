//
//  CityListView.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import SwiftUI

struct CityListView: View {
    @State private var viewModel: CityListViewModel

    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            TextField(text: $viewModel.currentPrefix) {
                Label("Search cities by name", systemImage: "magnifyingglass")
            }
            .onChange(of: viewModel.currentPrefix) { oldValue, newValue in
                Task {
                    await viewModel.searchPrefix(newValue)
                }
            }
            .padding(.horizontal, 24)

            List(viewModel.displayableCities) { item in
                Text(item.name)
                    .onAppear {
                        print(item.name)
                    }
            }
            .onAppear {
                Task {
                    await viewModel.loadCities()
                    await viewModel.loadFavorites()
                }
            }
        }
    }
}

#Preview {
    CityListView(
        viewModel: CityListViewModel(
            cityRepository: LocalCityRepository(searchableDataSet: TernarySearchTree()),
            favoritesRepository: MockFavoritesRepository(
                favoriteCities: []
            )
        )
    )
}
