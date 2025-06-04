//
//  StatCard.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.blue)

            Text(value)
                .font(.title2)
                .bold()

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 150, height: 120)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

//#Preview {
//    StatCard()
//}
