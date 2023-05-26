//
//  iosCapstone_Final_projectApp.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

@main
struct iosCapstone_Final_projectApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
