//
//  HereWeGoDriverApp.swift
//  HereWeGoDriver
//
//  Created by Ian Hoyos on 1/31/24.
//

import SwiftUI

@main
struct HereWeGoDriverApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
