//
//  ContentView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthManager
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()

                Text("🏋️‍♂️ Workout Progress")
                    .font(.largeTitle.bold())

                ProgressRing(progress: healthManager.progress)
                    .frame(width: 200, height: 200)

                VStack(spacing: 20) {
//                    Button(action: {
//                        healthManager.requestAuthorization()
//                        healthManager.fetchTodayWorkout()
//                    }) {
//                        Label("Fetch Today’s Workout", systemImage: "arrow.triangle.2.circlepath")
//                            .modifier(FitnessButtonStyle(background: .blue))
//                    }
//
//                    Button(action: {
//                        healthManager.saveWorkout(context: context)
//                    }) {
//                        Label("Save Workout", systemImage: "square.and.arrow.down.fill")
//                            .modifier(FitnessButtonStyle(background: .green))
//                    }

                    NavigationLink(destination: WorkoutListView()) {
                        Label("Workout List", systemImage: "list.bullet")
                            .modifier(FitnessButtonStyle(background: .orange))
                    }
                }

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(colors: [.white, .blue.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
}
