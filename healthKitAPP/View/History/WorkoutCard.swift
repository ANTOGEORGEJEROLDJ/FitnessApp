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
        VStack(alignment: .center, spacing: 5) {
                VStack{
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                            .font(.title2)
                        
                        Text(workout.title ?? "Unnamed Workout")
                            .font(.headline)
                    }
                    
                }
                .frame(width: 243, alignment: .leading)
                    
                
                
                VStack{
                    
                Text(workout.date ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("✅ Completed")
                    .font(.caption)
                    .foregroundColor(.green)
                    .padding(.top, 4)
            }
            .padding(.trailing, 150)
        }
        .frame(width: 300, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .shadow(radius: 5)
        .cornerRadius(15)
        
    }
}
//
//#Preview {
//    WorkoutCard()
//}
