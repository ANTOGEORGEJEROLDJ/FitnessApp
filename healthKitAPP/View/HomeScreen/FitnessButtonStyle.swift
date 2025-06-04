//
//  FitnessButtonStyle.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct FitnessButtonStyle: ViewModifier {
    var background: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(background)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}

//#Preview {
//    FitnessButtonStyle(background: .red)
//}
