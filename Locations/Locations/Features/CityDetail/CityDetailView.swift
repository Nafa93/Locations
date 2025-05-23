//
//  CityDetailView.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import SwiftUI

struct CityDetailView: View {
    @State private var viewModel: CityDetailViewModel

    init(viewModel: CityDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
                Color(uiColor: .systemGray6)

                VStack {
                    CityMapView(
                        viewModel: CityMapViewModel(
                            latitude: viewModel.latitude,
                            longitude: viewModel.longitude
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: geometryReader.size.height * 0.4)
                    .padding([.horizontal, .top], 24)

                    Form {
                        Section("Name") {
                            Text(viewModel.title)
                        }

                        Section("Country") {
                            Text(viewModel.countryName)
                        }

                        Section("Country Flag") {
                            Text(viewModel.countryFlag)
                        }

                        Section("Hemispheres") {
                            Text(viewModel.hemispheres)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CityDetailView(
        viewModel: CityDetailViewModel(
            city: City(
                id: 0,
                country: "AR",
                name: "Buenos Aires",
                coordinate: Coordinate(
                    longitude: -34.5875395,
                    latitude: -58.4261227
                )
            )
        )
    )
}
