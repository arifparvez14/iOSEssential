//
//  UserTravelHistoryView.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 10/5/23.
//

import SwiftUI

struct UserTravelHistoryView: View {
    @State private var userId: String = ""
    @StateObject var vm = ViewModel()

    var body: some View {
        VStack {
            TextField("user id...", text: $userId)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(.green))
                .cornerRadius(10)
                .padding(.horizontal)
            Button {
                vm.filterUserTravelHistory(userId: userId)
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

            Spacer()
        }
    }
}

struct UserTravelHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserTravelHistoryView()
    }
}
