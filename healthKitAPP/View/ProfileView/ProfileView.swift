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
        ScrollView {
            VStack(spacing: 24) {
                if let user = users.first {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(.top)
                    
                    VStack(spacing: 16) {
                        ProfileRow(label: "UserName", value: user.userName ?? "")
                        ProfileRow(label: "Email", value: user.email ?? "")
                        ProfileRow(label: "Age", value: "\(user.age)")
                        ProfileRow(label: "Gender", value: user.gender ?? "Not set")
                        ProfileRow(label: "Height", value: String(format: "%.1f cm", user.height))
                        ProfileRow(label: "Weight", value: String(format: "%.1f kg", user.weight))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.badge.exclamationmark")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)
                        Text("No profile data found")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Profile")
    }


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

//#Preview {
//    ProfileView()
////        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}


//struct ProfileView: View {
//    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 24) {
//                if let user = users.first {
//                    
//                    // Profile Icon
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .foregroundColor(.blue)
//                        .padding(.top)
//
//                    // User Info Card
//                    VStack(spacing: 16) {
//                        ProfileRow(label: "UserName", value: "\(user.userName)")
//                        ProfileRow(label: "email", value: "\(user.email)")
//                        ProfileRow(label: "Age", value: "\(user.age)")
//                        ProfileRow(label: "Gender", value: user.gender ?? "Not set")
//                        ProfileRow(label: "Height", value: "\(String(format: "%.1f", user.height)) cm")
//                        ProfileRow(label: "Weight", value: "\(String(format: "%.1f", user.weight)) kg")
//                    }
//
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.ultraThinMaterial)
//                    .cornerRadius(16)
//                    .shadow(radius: 5)
//
//                    // BMI Display
//                    if let bmi = calculateBMI(user: user) {
//                        VStack(spacing: 8) {
//                            Text("BMI: \(String(format: "%.1f", bmi))")
//                                .font(.title2.bold())
//                                .foregroundColor(.purple)
//                            Text(bmiDescription(bmi))
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//
//                    // Edit Button
//                    Button(action: {
//                        // Future: Open edit profile screen
//                    }) {
//                        Text("Edit Profile")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(12)
//                    }
//                    .padding(.top)
//                } else {
//                    VStack(spacing: 16) {
//                        Image(systemName: "person.crop.circle.badge.exclamationmark")
//                            .resizable()
//                            .frame(width: 80, height: 80)
//                            .foregroundColor(.gray)
//                        Text("No profile data found")
//                            .foregroundColor(.secondary)
//                    }
//                    .padding()
//                }
//            }
//            .padding()
//        }
//        .background(Color(.systemGroupedBackground).ignoresSafeArea())
//    }
//
//    func calculateBMI(user: User) -> Double? {
//        let heightInMeters = user.height / 100
//        guard heightInMeters > 0 else { return nil }
//        return user.weight / (heightInMeters * heightInMeters)
//    }
//
//    func bmiDescription(_ bmi: Double) -> String {
//        switch bmi {
//        case ..<18.5:
//            return "Underweight"
//        case 18.5..<24.9:
//            return "Normal weight"
//        case 25..<29.9:
//            return "Overweight"
//        default:
//            return "Obese"
//        }
//    }
//}
//
////#Preview {
////    ProfileView()
//////        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
////}
