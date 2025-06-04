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
        NavigationView{
            ScrollView {
                VStack(spacing: 32) {
                    if let user = users.first {
                        // Profile Image
                        //                    Image(systemName: "person.crop.circle.fill")
                        //                        .resizable()
                        //                        .scaledToFit()
                        //                        .frame(width: 120, height: 120)
                        //                        .foregroundColor(.blue)
                        //                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        //                        .padding(.top, 40)
                        
                        // User Info Card
                        VStack(spacing: 20) {
                            ProfileRow(label: "Username", value: user.userName ?? "N/A")
                            ProfileRow(label: "Email", value: user.email ?? "N/A")
                            ProfileRow(label: "Age", value: "\(user.age)")
                            ProfileRow(label: "Gender", value: user.gender ?? "Not set")
                            ProfileRow(label: "Height", value: String(format: "%.1f cm", user.height))
                            ProfileRow(label: "Weight", value: String(format: "%.1f kg", user.weight))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.ultraThinMaterial)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        
                        // BMI Card
                        if let bmi = calculateBMI(user: user) {
                            VStack(spacing: 12) {
                                Text("Your BMI")
                                    .font(.title2.bold())
                                    .foregroundColor(.primary)
                                
                                ZStack {
                                    Circle()
                                        .stroke(lineWidth: 20)
                                        .opacity(0.2)
                                        .foregroundColor(Color.blue)
                                    
                                    Circle()
                                        .trim(from: 0, to: CGFloat(min(bmi / 40, 1))) // Normalized assuming max BMI ~40
                                        .stroke(
                                            AngularGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red]), center: .center),
                                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                        )
                                        .rotationEffect(.degrees(-90))
                                        .animation(.easeOut(duration: 1.2), value: bmi)
                                    
                                    VStack {
                                        Text(String(format: "%.1f", bmi))
                                            .font(.largeTitle.bold())
                                            .foregroundColor(.primary)
                                        Text(bmiDescription(bmi))
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .frame(width: 180, height: 180)
                                .padding(.bottom)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(Color.blue.opacity(0.1))
                                    .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 5)
                            )
                            .padding(.horizontal)
                        }
                    } else {
                        // No Profile Data
                        VStack(spacing: 24) {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .scaledToFit()
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
                    NavigationLink(destination:loginScreen()){
                        Text("LogOut")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.bottom, 40)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("👤 Profile")
        }.navigationTitle("Profile")
    }

    // MARK: - BMI Calculation
    
    func calculateBMI(user: User) -> Double? {
        let heightInMeters = user.height / 100
        guard heightInMeters > 0 else { return nil }
        return user.weight / (heightInMeters * heightInMeters)
    }

    func bmiDescription(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight"
        case 18.5..<24.9:
            return "Normal weight"
        case 25..<29.9:
            return "Overweight"
        default:
            return "Obese"
        }
    }
}

//struct ProfileRow: View {
//    let label: String
//    let value: String
//
//    var body: some View {
//        HStack {
//            Text(label)
//                .font(.headline)
//                .foregroundColor(.primary)
//            Spacer()
//            Text(value)
//                .font(.body)
//                .foregroundColor(.secondary)
//        }
//        .padding(.horizontal)
//    }
//}
