//
//  City+CoreData.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//

extension City {
    init(model: CityDataModel) {
        self.id = Int(model.id)
        self.country = model.country ?? ""
        self.name = model.name ?? ""
        self.coordinate = Coordinate(longitude: model.longitude, latitude: model.latitude)
    }
}
