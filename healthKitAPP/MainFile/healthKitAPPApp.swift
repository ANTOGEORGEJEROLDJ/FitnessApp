//
//  healthKitAPPApp.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct healthKitAPPApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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
