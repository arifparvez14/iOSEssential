//
//  GoodStoreApp.swift
//  GoodStore
//
//  Created by Muhammad Ariful Islam on 10/5/23.
//

import SwiftUI
import CloudKit

@main
struct GoodStoreApp: App {

    let container = CKContainer(identifier: "iCloud.teamPT.bjitgroup.upskilldev")

    var body: some Scene {
        WindowGroup {
            ContentView(vm: ItemListViewModel(container: container))
        }
    }
}
