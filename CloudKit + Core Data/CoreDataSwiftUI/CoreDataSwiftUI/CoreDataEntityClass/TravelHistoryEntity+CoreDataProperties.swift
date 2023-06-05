//
//  TravelHistoryEntity+CoreDataProperties.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 11/5/23.
//
//

import Foundation
import CoreData


extension TravelHistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TravelHistoryEntity> {
        return NSFetchRequest<TravelHistoryEntity>(entityName: "TravelHistoryEntity")
    }

    @NSManaged public var busId: String?
    @NSManaged public var departureTime: Date?
    @NSManaged public var scheduleTime: Date?
    @NSManaged public var travelDate: String?
    @NSManaged public var userId: String?
    @NSManaged public var userStatus: String?

}

extension TravelHistoryEntity {

}
