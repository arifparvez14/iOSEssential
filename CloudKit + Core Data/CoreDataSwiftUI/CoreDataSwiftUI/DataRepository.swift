//
//  DataRepository.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 4/5/23.
//

import CoreData
import SwiftUI

protocol Repository{
    func fetchHistory()
    func saveHistory()
    func addHistory(entity: TravelHistoryModel)
    func deleteHistory(indexSet: IndexSet)
    func updateHistory(entity: TravelHistoryEntity)
    func filterDateWiseBusTravelHistory(busId: String, date: String)
    func filterUserTravelHistory(userId: String)
}

class DataRepository: ObservableObject, Repository {
    let container: NSPersistentCloudKitContainer
    @Published var savedEntities: [TravelHistoryEntity] = []
    @Published var filteredEntity: [TravelHistoryEntity] = []

    init() {
        container = NSPersistentCloudKitContainer(name: "DBContainer")

        container.loadPersistentStores{ (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        fetchHistory()
    }

    func fetchHistory() {
        let request = NSFetchRequest<TravelHistoryEntity>(entityName: "TravelHistoryEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }

    func addHistory(entity: TravelHistoryModel) {
        let newHistory = TravelHistoryEntity(context: container.viewContext)
        newHistory.busId = entity.busId
        newHistory.departureTime = entity.departureTime
        newHistory.scheduleTime = entity.scheduleTime

        newHistory.travelDate = entity.travelDate
        newHistory.userId = entity.userId
        newHistory.userStatus = entity.userStatus


        saveHistory()
    }

    func deleteHistory(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveHistory()
    }

    func updateHistory(entity: TravelHistoryEntity) {
        if entity.userStatus == UserStatus.coming.rawValue {
            entity.userStatus = UserStatus.checkin.rawValue
        }
        saveHistory()
    }

    func saveHistory() {
        do {
            try container.viewContext.save()
            fetchHistory()
        } catch let error {
            print("Error saving. \(error)")
        }
    }

    func filterDateWiseBusTravelHistory(busId: String, date: String) {
        let request = NSFetchRequest<TravelHistoryEntity>(entityName: "TravelHistoryEntity")
        request.predicate = NSPredicate(format: "busId == %@ AND travelDate == %@", busId, date)

        do {
            filteredEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }

    func filterUserTravelHistory(userId: String) {
        let request = NSFetchRequest<TravelHistoryEntity>(entityName: "TravelHistoryEntity")
        request.predicate = NSPredicate(format: "userId == %@", userId)

        do {
            filteredEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
}


