//
//  HealthDashboardView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import CoreData

struct HealthDashboardView: View {
    
    @StateObject var healthManager = HealthManager()

    @Environment(\.managedObjectContext) var context

    var body: some View {
        VStack(spacing: 20) {
            Text("Workout Summary")
                .font(.largeTitle)
                .bold()

            ProgressView(value: healthManager.progress)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            Text("Steps: \(healthManager.steps)")
            Text("Calories: \(Int(healthManager.calories)) kcal")
            Text("Duration: \(Int(healthManager.workoutDuration / 60)) minutes")

            Button("Save Workout") {
                healthManager.saveWorkout(context: context)
            }
            .padding()
            .background(Color.green.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear {
            healthManager.requestAuthorization()
            healthManager.fetchTodayWorkout()
        }
        .padding()
    }
}
struct HealthDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDashboardView()
            .environment(\.colorScheme, .dark)
    }
}
