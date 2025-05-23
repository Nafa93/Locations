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
                    ZStack(alignment: .center) {
                        SplashView(title: viewModel.title)
                    }
                    .frame(width: geometryReader.size.width, height: geometryReader.size.height)
                } else {
                    if isPortrait {
                        CityListView(viewModel: viewModel.cityListViewModel)
                            .padding(.top, 52)
                    } else {
                        HStack(spacing: 0) {
                            if viewModel.isSideListVisible {
                                CityListView(viewModel: viewModel.cityListViewModel)
                                    .padding(.top, 20)
                                    .frame(width: geometryReader.size.width * 0.4)
                            }

                            ZStack(alignment: .topLeading) {
                                CityMapView(viewModel: viewModel.mapViewModel)

                                Button {
                                    withAnimation {
                                        viewModel.toggleSideList()
                                    }
                                } label: {
                                    Image(systemName: viewModel.isSideListVisible ? "sidebar.leading" : "sidebar.trailing")
                                        .padding()
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .padding()
                            }
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
        .animation(.easeInOut, value: viewModel.isSideListVisible)
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
                .accessibilityIdentifier("splash.title")

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
