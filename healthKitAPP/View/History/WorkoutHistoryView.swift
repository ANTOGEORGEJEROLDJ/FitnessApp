//
//  WorkoutHistoryView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct WorkoutHistoryView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)],
        predicate: NSPredicate(format: "isCompleted == true")
    ) var workouts: FetchedResults<Workout>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if workouts.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Image(systemName: "figure.walk.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                        Text("No completed workouts yet")
                            .font(.title3.bold())
                            .foregroundColor(.gray)
                        Text("Once you complete a workout, it'll show up here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
//                    .frame(width: 410)
                    .padding(.top, 100)
                } else {
                    ForEach(workouts) { workout in
                        WorkoutHistoryCard(workout: workout)
                    }
                }
            }
            .frame(width: 410)
            .padding()
        }
        .frame(width: 410)
        .navigationTitle("🏆 Workout History")
        .background(Color.white.opacity(0.8))
        
    }
}
struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        // Insert mock data for preview
        let sampleWorkout = Workout(context: context)
        sampleWorkout.title = "10 Push-ups"
        sampleWorkout.date = Date()
        sampleWorkout.isCompleted = true
        
        let sampleWorkout2 = Workout(context: context)
        sampleWorkout2.title = "Yoga 15 mins"
        sampleWorkout2.date = Date().addingTimeInterval(-86400)
        sampleWorkout2.isCompleted = true
        
        return NavigationView {
            WorkoutHistoryView()
                .environment(\.managedObjectContext, context)
        }
    }
}


