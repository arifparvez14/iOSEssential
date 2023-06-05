//
//  FilterView.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 9/5/23.
//

import SwiftUI

struct FilterView: View {
    @State private var showBusWiseFilterView = false
    @State private var showUserWiseFilterView = false

    var body: some View {
        VStack {
            Button(action: { showBusWiseFilterView = true }) {
                Text("Bus travel history")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.red))
                    .cornerRadius(10)
            }.padding(.horizontal)
            NavigationLink("", destination:  BusTravelHistoryView(), isActive: $showBusWiseFilterView)

            Button(action: { showUserWiseFilterView = true }) {
                Text("User travel history")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color(.red))
                    .cornerRadius(10)
            }.padding(.horizontal)
            NavigationLink("", destination:  UserTravelHistoryView(), isActive: $showUserWiseFilterView)

            Spacer()
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
