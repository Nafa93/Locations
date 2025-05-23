//
//  CityCellView.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import SwiftUI

struct CityCellView: View {
    @State private var viewModel: CityCellViewModel

    init(viewModel: CityCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.subheadline)

                Text(viewModel.latitudeSubtitle)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.5))

                Text(viewModel.longitudeSubtitle)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.5))
            }

            Spacer()

            Button {
                viewModel.favoriteButtonHandler()
            } label: {
                Image(systemName: viewModel.favoriteImageName)
            }
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(viewModel.favoriteBackgroundColor)
                    .stroke(.yellow)
            )
            .buttonStyle(.borderless)
            .tint(viewModel.favoriteStarColor)


            Button {
                viewModel.detailButtonHandler()
            } label: {
                Text("Detail")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(8)
        .background(.white)
        .onTapGesture {
            viewModel.cellTapHandler()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CityCellView(viewModel: CityCellViewModel(
        city: City(
            id: 0,
            country: "AR",
            name: "Buenos Aires",
            coordinate: Coordinate(
                longitude: 0.0,
                latitude: 0.0
            )
        ),
        isFavorite: true,
        onFavoritesButtonTapped: {
            city in print(
                city
            )
        },
        onCellTapped: { city in
            print(city)
        },
        onDetailButtonTapped: { city in
            print(city)
        }
    ))
}
