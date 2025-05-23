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
        Map(position: $viewModel.position) {
//            Marker("Testing", coordinate: viewModel.position.camera?.centerCoordinate)
        }
    }
}

#Preview {
    CityMapView(viewModel: CityMapViewModel())
}
