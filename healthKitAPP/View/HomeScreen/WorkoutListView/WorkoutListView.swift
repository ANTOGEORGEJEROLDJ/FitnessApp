//
//  WorkoutListView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//



import SwiftUI

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
                        .frame(maxWidth: .infinity, alignment: .leading)
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

    /// Adds default workout tasks if none exist
    func addDefaultTasks() {
        let taskNames = ["5km Run", "10 Push-ups", "15 min Yoga", "Plank 1 min", "Jump Rope 200x"]

        for name in taskNames {
            let workout = Workout(context: context)
            workout.title = name
            workout.date = Date()
            workout.isCompleted = false
        }

        saveContext()
        healthManager.updateProgressFromCoreData(context: context)
    }
}
struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let healthManager = HealthManager()

        return WorkoutListView()
            .environment(\.managedObjectContext, context)
            .environmentObject(healthManager)
    }
}
