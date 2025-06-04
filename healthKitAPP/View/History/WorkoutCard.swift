//
//  WorkoutCard.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct IconLabel: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
                .font(.subheadline)
        }
    }
}


struct WorkoutCard: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text(formattedDate)
                    .font(.headline)
            }

            HStack {
                IconLabel(icon: "flame.fill", text: "\(workout.calories) kcal", color: .red)
                Spacer()
                IconLabel(icon: "figure.walk", text: "\(workout.steps) steps", color: .orange)
            }

            HStack {
                IconLabel(icon: "clock.fill", text: "\(durationInMinutes) mins", color: .green)
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 3)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: workout.date ?? Date())
    }

    var durationInMinutes: Int {
        Int(workout.duration / 60)
    }
}
//
//#Preview {
//    WorkoutCard()
//}
