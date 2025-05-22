//
//  CityMapView.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 22/05/2025.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    @State private var viewModel: CityMapViewModel

    init(viewModel: CityMapViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Map(initialPosition: .region(viewModel.region)) {
            Marker("Testing", coordinate: viewModel.region.center)
        }
    }
}

#Preview {
    CityMapView(viewModel: CityMapViewModel())
}
