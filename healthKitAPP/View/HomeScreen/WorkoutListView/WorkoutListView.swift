//
//  WorkoutListView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//


import SwiftUI

import SwiftUI
import CoreData

struct WorkoutListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)],
        animation: .default
    )
    var workouts: FetchedResults<Workout>

    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var healthManager: HealthManager

    var body: some View {
        List {
            ForEach(workouts) { workout in
                VStack(alignment: .leading, spacing: 8) {
                    Text(workout.title ?? "Unnamed Task")
                        .font(.headline)
                    
                    Text(workout.date ?? Date(), style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if !workout.isCompleted {
                        Button("Mark as Completed") {
                            workout.isCompleted = true
                            saveContext()
                            healthManager.updateProgressFromCoreData(context: context)
                        }
                        .padding(6)
                        .frame(width: 180)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    } else {
                        Text("✅ Completed")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Workout Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Tasks", action: addDefaultTasks)
            }
        }
    }
        
        func saveContext() {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }

    
    func addDefaultTasks() {
        let defaultTasks = [
            ("5km Run", 1800.0, 300.0),
            ("10 Push-ups", 120.0, 50.0),
            ("15 min Yoga", 900.0, 100.0),
            ("Plank 1 min", 60.0, 20.0),
            ("Jump Rope 200x", 300.0, 150.0)
        ]

        for (title, duration, calories) in defaultTasks {
            let workout = Workout(context: context)
            workout.title = title
            workout.date = Date()
            workout.isCompleted = false
            workout.duration = duration
            workout.calories = calories
        }

        saveContext()
        healthManager.updateProgressFromCoreData(context: context)
    }
}
