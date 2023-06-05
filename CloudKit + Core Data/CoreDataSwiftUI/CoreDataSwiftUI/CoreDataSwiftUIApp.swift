//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by Muhammad Ariful Islam on 2/5/23.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    @AppStorage("isRegistered") var isRegistered: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !isRegistered {
                RegistrationView()
            } else {
                RegistrationView()
            }
        }
    }
}
