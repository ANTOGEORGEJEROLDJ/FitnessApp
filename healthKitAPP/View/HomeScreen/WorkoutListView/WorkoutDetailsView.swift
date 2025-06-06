//
//  WorkoutDetailsView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 06/06/25.
//

import SwiftUI
import CoreData

// MARK: - Workout Details Component
struct WorkoutDetailsView: View {
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch title {
            case "10 Push-ups":
                Text("💪 Push-ups Instructions")
                    .font(.headline)
                Text("""
                - Start in a plank position with hands under shoulders.
                - Lower your body until your chest nearly touches the floor.
                - Push back up and repeat.
                
                Benefits:
                - Strengthens chest, triceps, and core.
                - Improves posture and endurance.
                """)
                    .font(.subheadline)

            case "15 min Yoga":
                Text("🧘 Yoga Routine")
                    .font(.headline)
                Text("""
                - 5 mins: Breathing & centering
                - 5 mins: Sun salutations & poses
                - 5 mins: Meditation & cooldown

                Benefits:
                - Increases flexibility
                - Reduces anxiety and stress
                - Enhances focus and relaxation
                """)
                    .font(.subheadline)

            case "Plank 1 min":
                Text("🧍 Plank Instructions")
                    .font(.headline)
                Text("""
                - Keep forearms and toes on the floor, back straight.
                - Tighten your abs and hold the position.

                Benefits:
                - Builds core strength
                - Improves balance and endurance
                - Tones abs and back
                """)
                    .font(.subheadline)

            case "Jump Rope 200x":
                Text("🤸 Jump Rope Routine")
                    .font(.headline)
                Text("""
                - Use a rope of suitable length.
                - Keep elbows close to body and rotate wrists.
                - Jump just high enough to clear the rope.
                - Perform 200 repetitions.

                Benefits:
                - Burns fat quickly
                - Improves coordination and stamina
                - Fun cardio workout
                """)
                    .font(.subheadline)

            default:
                Text("ℹ️ General Info")
                    .font(.headline)
                Text("No specific instructions available for this workout.")
                    .font(.subheadline)
            }
        }
        .padding(.top)
    }
}
