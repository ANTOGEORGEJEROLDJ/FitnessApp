//
//  ProgressRingView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct ProgressRingView: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 15)

            Circle()
                .trim(from: 0, to: min(progress, 1))
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red]), center: .center),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: progress)

            VStack {
                Text("Progress")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("\(Int(progress * 100))%")
                    .font(.title2.bold())
            }
        }
    }
}
