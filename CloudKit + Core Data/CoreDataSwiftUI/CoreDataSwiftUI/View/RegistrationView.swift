//
//  RegistrationView.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 8/5/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var userId = ""
    @State private var password = ""
    @AppStorage("isRegistered") var isRegistered: Bool?
    @State private var showHistoryView = false
    @State private var showFilterView = false
    
    
    var body: some View {
        NavigationView{
            VStack() {
                VStack(alignment: .center) {
                    TextField("UserId", text: self.$userId)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(20.0)
                    
                    SecureField("Password", text: self.$password)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(20.0)
                    
                    Button(action: {
                        print("Register")
                        isRegistered = true
                        
                    }, label: {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color(.blue))
                            .cornerRadius(10)
                    }).padding(.horizontal)
                    
                    Button(action: { showHistoryView = true }) {
                        Text("Add History")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color(.orange))
                            .cornerRadius(10)
                    }.padding(.horizontal)
                    NavigationLink("", destination:  HistoryView(), isActive: $showHistoryView)
                    
                    Button(action: { showFilterView = true }) {
                        Text("Filter History")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color(.red))
                            .cornerRadius(10)
                    }.padding(.horizontal)
                    NavigationLink("", destination:  FilterView(), isActive: $showFilterView)
                    
                }.padding()
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
