//
//  BusEntity+CoreDataProperties.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 11/5/23.
//
//

import Foundation
import CoreData


extension BusEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusEntity> {
        return NSFetchRequest<BusEntity>(entityName: "BusEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var numOfSeat: Int64

}

extension BusEntity : Identifiable {

}
