//
//  FilterUserByBusView.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 10/5/23.
//

import SwiftUI

struct BusTravelHistoryView: View {
    @StateObject var vm = ViewModel()
    @State private var busId: String = BusId.A.rawValue
    private let busIds = [BusId.A.rawValue, BusId.B.rawValue, BusId.C.rawValue, BusId.D.rawValue]
    @State private var journeyDate = Date.now
    
    var body: some View {
        VStack {
            HStack() {
                Text("Bus Id")
                    .font(.title3)

                Picker("Select a status", selection: $busId) {
                    ForEach(busIds, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }

            DatePicker("Pick journey date",
                        selection: $journeyDate,
                        in: ...Date.now,
                        displayedComponents: [.date])
                        .padding()

            Button {
                vm.filterDateWiseBusTravelHistory(busId: busId, date: journeyDate)
            } label: {
                Text("Filter")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.red))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()

            List {
                ForEach(vm.filteredEntity) { entity in
                    HStack() {
                        Text("UserId: \(entity.userId ?? "No UserId Found") " )
                        Text("BusId: \(entity.busId ?? "No BusId Found")" )
                        Text("Journey Date: \(entity.travelDate ?? "")")
                        Text("User Status: \(entity.userStatus ?? "No Status")")
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct FilterUserByBusView_Previews: PreviewProvider {
    static var previews: some View {
        BusTravelHistoryView()
    }
}
