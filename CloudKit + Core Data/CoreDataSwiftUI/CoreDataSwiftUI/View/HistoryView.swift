//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 2/5/23.
//

import SwiftUI

struct HistoryView: View {
    @StateObject var vm = ViewModel()
    @State private var userId: String = ""
    @State private var busId: String = BusId.A.rawValue
    @State private var selectedStatus = UserStatus.coming.rawValue
    private let status = [UserStatus.coming.rawValue, UserStatus.checkin.rawValue]
    private let busIds = [BusId.A.rawValue, BusId.B.rawValue, BusId.C.rawValue, BusId.D.rawValue]
    @State private var journeyDate = Date.now
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("user id...", text: $userId)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color(.green))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
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

                HStack() {
                    Text("User Status")
                        .font(.title3)

                    Picker("Select a status", selection: $selectedStatus) {
                        ForEach(status, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }

                
                Button {
                    guard !userId.isEmpty, !busId.isEmpty else { return }
                    vm.addHistory(
                        userId: userId,
                        busId: busId,
                        userStatus: selectedStatus,
                        journeyDate: journeyDate)
                    self.userId = ""
                } label: {
                    Text("Save")
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
                    ForEach(vm.savedEntities) { entity in
                        HStack() {
                            Text("UserId: \(entity.userId ?? "No UserId Found") " )
                            Text("BusId: \(entity.busId ?? "No BusId Found")" )
                            Text("Journey Date: \(entity.travelDate ?? "")")
                            Text("User Status: \(entity.userStatus ?? "No Status")")
                        }.onTapGesture {
                            vm.updateHistory(entity: entity)
                        }
                    }
                    .onDelete(perform: vm.deleteHistory)
                }
                .listStyle(.plain)
            }
            .onAppear {
                vm.fetchHistory()
            }
            .navigationTitle("Travel History")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
