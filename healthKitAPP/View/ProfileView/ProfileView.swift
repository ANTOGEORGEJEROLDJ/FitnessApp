//
//  ProfileView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    if let user = users.first {
                        // Profile Info...
                        VStack(spacing: 20) {
                            ProfileRow(label: "Username", value: user.userName ?? "N/A")
                            ProfileRow(label: "Email", value: user.email ?? "N/A")
                            ProfileRow(label: "Age", value: "\(user.age)")
                            ProfileRow(label: "Gender", value: user.gender ?? "Not set")
                            ProfileRow(label: "Height", value: String(format: "%.1f cm", user.height))
                            ProfileRow(label: "Weight", value: String(format: "%.1f kg", user.weight))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25).fill(.ultraThinMaterial).shadow(radius: 10))
                        .padding(.horizontal)
                    }


                    // Logout Button
                    NavigationLink(destination: loginScreen()) {
                        Text("Log Out")
                            .frame(width: 200)
                            .padding()
                            .bold()
                            .background(Color.purple.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Profile")
            .navigationBarBackButtonHidden(true) // 🔴 Hide Back Button
        }
    }

    func calculateBMI(user: User) -> Double? {
        let heightInMeters = user.height / 100
        guard heightInMeters > 0 else { return nil }
        return user.weight / (heightInMeters * heightInMeters)
    }

    func bmiDescription(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<24.9: return "Normal weight"
        case 25..<29.9: return "Overweight"
        default: return "Obese"
        }
    }
}
