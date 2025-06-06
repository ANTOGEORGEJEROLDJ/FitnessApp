//
//  TeamsPage.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct CustomTextField: View {
    var icon: String
    var placeHolder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 30)

            if placeHolder.lowercased().contains("password") {
                SecureField(placeHolder, text: $text)
            } else {
                TextField(placeHolder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(3)
        .cornerRadius(12)
    }
}
