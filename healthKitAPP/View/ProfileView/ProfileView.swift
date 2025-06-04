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

                        // BMI Ring...
                        if let bmi = calculateBMI(user: user) {
                            VStack(spacing: 12) {
                                Text("Your BMI").font(.title2.bold())
                                ZStack {
                                    Circle()
                                        .stroke(lineWidth: 20)
                                        .opacity(0.2)
                                        .foregroundColor(Color.blue)

                                    Circle()
                                        .trim(from: 0, to: CGFloat(min(bmi / 40, 1)))
                                        .stroke(AngularGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red]), center: .center),
                                                style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeOut(duration: 1.2), value: bmi)

                                    VStack {
                                        Text(String(format: "%.1f", bmi))
                                            .font(.largeTitle.bold())
                                        Text(bmiDescription(bmi))
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .frame(width: 180, height: 180)
                                .padding(.bottom)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.blue.opacity(0.1)).shadow(radius: 10))
                            .padding(.horizontal)
                        }
                    } else {
                        // No data state...
                        VStack(spacing: 24) {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray.opacity(0.7))

                            Text("No profile data found")
                                .font(.title3.bold())
                                .foregroundColor(.secondary)

                            Text("Please add your profile information to see details here.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .padding(.top, 100)
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
