//
//  SessionManager.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 06/06/25.
//

import SwiftUI
import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    func login(user: User) {
        self.currentUser = user
        self.isLoggedIn = true
    }
    
    func logout() {
        self.currentUser = nil
        self.isLoggedIn = false
    }
}
