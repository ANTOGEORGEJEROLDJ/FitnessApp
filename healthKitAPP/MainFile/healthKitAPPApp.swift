//
//  healthKitAPPApp.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

@main
struct healthKitAPPApp: App {
    @StateObject var healthManager = HealthManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            loginScreen()
                .environmentObject(healthManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
