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
        VStack(spacing: 0) {
            VStack(spacing: 20) {
                TextField(text: $viewModel.currentPrefix) {
                    Label("Search cities by name", systemImage: "magnifyingglass")
                }
                .textFieldStyle(.roundedBorder)
                .onChange(of: viewModel.currentPrefix) { _, newValue in
                    Task {
                        await viewModel.searchPrefix(newValue)
                    }
                }

                Toggle(isOn: $viewModel.isFavoritesOn) {
                    Text("Favorites")
                }
                .onChange(of: viewModel.isFavoritesOn) { _, _ in
                    Task {
                        await viewModel.searchPrefix(viewModel.currentPrefix)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)

            Divider()

            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.displayableCities) { item in
                        CityCellView(
                            viewModel: CityCellViewModel(
                                city: item,
                                isFavorite: viewModel.isFavorite(item),
                                onFavoritesButtonTapped: { city in
                                    Task {
                                        await viewModel.upsertFavorite(city)
                                    }
                                },
                                onCellTapped: { city in
                                    Task {
                                        await viewModel.onCellTapped(city)
                                    }
                                },
                                onDetailButtonTapped: { city in
                                    viewModel.onDetailTapped(city)
                                }
                            )
                        )

                        Divider()
                    }
                }
            }
            .safeAreaPadding(.horizontal, 24)
        }
    }
}

#Preview {
    CityListView(
        viewModel: CityListViewModel(
            cityRepository: LocalCityRepository(
                searchableDataSet: TernarySearchTree()
            ),
            favoritesRepository: MockFavoritesRepository(
                favoriteCities: [
                    City(id: 0, country: "AR", name: "Buenos Aires", coordinate: Coordinate(longitude: 0.0, latitude: 0.0))
                ]
            )
        )
    )
}
