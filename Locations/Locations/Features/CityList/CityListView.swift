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
            // TODO: Make textfield stick to top
            HStack(spacing: 20) {
                TextField(text: $viewModel.currentPrefix) {
                    Label("Search cities by name", systemImage: "magnifyingglass")
                }
                .textFieldStyle(.roundedBorder)
                .onChange(of: viewModel.currentPrefix) { oldValue, newValue in
                    Task {
                        await viewModel.searchPrefix(newValue)
                    }
                }

                Button {
                    Task {
                        await viewModel.toggleFavorites()
                    }
                } label: {
                    Text("Favorites")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 24)

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
                                    print(
                                        city
                                    )
                                },
                                onDetailButtonTapped: { city in
                                    print(
                                        city
                                    )
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
