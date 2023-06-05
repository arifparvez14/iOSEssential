//
//  ViewModel.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 4/5/23.
//

import CoreData

class ViewModel: ObservableObject {
    @Published var savedEntities: [TravelHistoryEntity] = []
    @Published var filteredEntity: [TravelHistoryEntity] = []

    var coreDataRepository: DataRepository
    
    init() {
        self.coreDataRepository = DataRepository()
        savedEntities = coreDataRepository.savedEntities
    }
    
    func fetchHistory() {
        coreDataRepository.fetchHistory()
        updateHistoryValue()
    }
    
    func addHistory(userId: String, busId: String, userStatus: String, journeyDate: Date) {
        let travelHistoryModel = TravelHistoryModel (
            userId: userId,
            busId: busId,
            travelDate: dateToString(date: journeyDate),
            scheduleTime: Date(),
            departureTime: Date(),
            userStatus: userStatus)

        coreDataRepository.addHistory(entity: travelHistoryModel)
        updateHistoryValue()
    }
    
    func deleteHistory(indexSet: IndexSet) {
        coreDataRepository.deleteHistory(indexSet: indexSet)
        updateHistoryValue()
    }
    
    func updateHistory(entity: TravelHistoryEntity) {
        coreDataRepository.updateHistory(entity: entity)
        updateHistoryValue()
    }

    private func updateHistoryValue() {
        coreDataRepository.$savedEntities.sink { histories in
            self.savedEntities = histories
        }
    }

    //MARK: - Filter
    func filterDateWiseBusTravelHistory(busId: String, date: Date) {
        coreDataRepository.filterDateWiseBusTravelHistory(busId: busId, date: dateToString(date: date))
        updateFilteredHistoryValue()
    }

    func filterUserTravelHistory(userId: String) {
        coreDataRepository.filterUserTravelHistory(userId: userId)
        updateFilteredHistoryValue()
    }

    private func updateFilteredHistoryValue() {
        coreDataRepository.$filteredEntity.sink { filteredHistories in
            self.filteredEntity = filteredHistories
        }
    }

    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = .current
        let currentDateStr = dateFormatter.string(from: date)
        return currentDateStr
    }
}
