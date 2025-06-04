//
//  MainTabView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Label("Dashboard", systemImage: "heart.fill")
            }
            WorkoutHistoryView().tabItem {
                Label("History", systemImage: "clock")
            }
            WorkoutSummaryView().tabItem{
                Label("Summary", systemImage: "list.dash.header.rectangle")
            }
            ProfileView().tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }.navigationBarBackButtonHidden(true)
    }
}
