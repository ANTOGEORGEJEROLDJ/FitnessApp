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

struct WorkoutHistoryCard: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.title2)
                Text(workout.title ?? "Unnamed Workout")
                    .font(.headline)
            }

            Text(workout.date ?? Date(), style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("✅ Completed")
                .font(.caption)
                .foregroundColor(.green)
                .padding(.top, 4)
        }
        .padding()
        .frame(width: 360)
        .shadow(radius: 30)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}
//
//#Preview {
//    WorkoutCard()
//}
