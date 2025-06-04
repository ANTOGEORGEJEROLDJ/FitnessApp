//
//  WorkoutHistoryView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

import SwiftUI

struct WorkoutHistoryView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)]
    ) var workouts: FetchedResults<Workout>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if workouts.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "tray")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No workout history yet.")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 50)
                    } else {
                        ForEach(workouts) { workout in
                            WorkoutCard(workout: workout)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Workout History")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}
