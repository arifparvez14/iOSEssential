//
//  Model.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 9/5/23.
//

import Foundation

enum UserStatus: String {
    case coming = "Coming"
    case checkin = "Checkin"
}

struct TravelHistoryModel {
    var userId: String
    var busId: String
    var travelDate: String
    var scheduleTime: Date
    var departureTime: Date
    var userStatus: String
}

enum BusId: String {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
}
