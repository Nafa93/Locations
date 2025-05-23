//
//  CityDataModel+CoreDataProperties.swift
//  Locations
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 23/05/2025.
//
//

import Foundation
import CoreData

extension CityDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityDataModel> {
        return NSFetchRequest<CityDataModel>(entityName: "CityDataModel")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?

}

extension CityDataModel : Identifiable {

}
