//
//  WorkoutSummaryView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct WorkoutSummaryView: View {
    @EnvironmentObject var healthManager: HealthManager

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("🏋️‍♂️ Workout Summary")
                    .font(.largeTitle.bold())
                    .padding(.top)

                HStack(spacing: 16) {
                    SummaryCard(icon: "flame.fill", title: "Calories", value: "\(Int(healthManager.calories)) kcal", color: .red)
                    SummaryCard(icon: "figure.walk", title: "Steps", value: "\(healthManager.steps)", color: .blue)
                }

                SummaryCard(icon: "clock.fill", title: "Duration", value: formattedDuration, color: .green)

                VStack(spacing: 16) {
                    Text("Daily Progress")
                        .font(.title2.bold())
                    ProgressRingView(progress: healthManager.progress)
                        .frame(width: 150, height: 150)
                }

                Button(action: {
                    healthManager.fetchTodayWorkout()
                }) {
                    Text("Refresh Data")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .onAppear {
            healthManager.requestAuthorization()
            healthManager.fetchTodayWorkout()
            // Pull from Core Data as well
            if let context = healthManager.context {
                healthManager.updateProgressFromCoreData(context: context)
            }
        }
    }

    var formattedDuration: String {
        let minutes = Int(healthManager.workoutDuration) / 60
        let seconds = Int(healthManager.workoutDuration) % 60
        return "\(minutes) min \(seconds) sec"
    }
}
