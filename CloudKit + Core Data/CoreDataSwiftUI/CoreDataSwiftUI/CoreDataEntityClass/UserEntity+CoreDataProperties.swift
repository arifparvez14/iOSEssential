//
//  UserEntity+CoreDataProperties.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 11/5/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var userName: String?

}

extension UserEntity : Identifiable {

}
