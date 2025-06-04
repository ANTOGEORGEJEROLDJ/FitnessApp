//
//  DetailFormView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct DetailFormView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    @State private var age = ""
    @State private var gender = ""
    @State private var height = ""
    @State private var weight = ""
    
    @State private var showSuccess = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Tell Us About Yourself")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                VStack(spacing: 16) {
                    InputField(icon: "calendar", title: "Age", text: $age, keyboard: .numberPad)
                    InputField(icon: "figure.dress.line.vertical.figure", title: "Gender", text: $gender)
                    InputField(icon: "ruler", title: "Height (cm)", text: $height, keyboard: .decimalPad)
                    InputField(icon: "scalemass", title: "Weight (kg)", text: $weight, keyboard: .decimalPad)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .shadow(radius: 5)
                
                Button(action: saveProfile) {
                    Text("Save Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .alert("Profile Saved!", isPresented: $showSuccess) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Your Details")
        .onAppear {
            // Prefill if user exists
            if let user = users.first {
                age = user.age > 0 ? "\(user.age)" : ""
                gender = user.gender ?? ""
                height = user.height > 0 ? String(format: "%.1f", user.height) : ""
                weight = user.weight > 0 ? String(format: "%.1f", user.weight) : ""
            }
        }
    }
    
    private func saveProfile() {
        guard let user = users.first else {
            print("No user found to update")
            return
        }
        
        user.age = Int16(age) ?? 0
        user.gender = gender.isEmpty ? nil : gender
        user.height = Double(height) ?? 0
        user.weight = Double(weight) ?? 0
        
        do {
            try context.save()
            showSuccess = true
        } catch {
            print("Failed to save profile details: \(error)")
        }
    }
}



struct InputField: View {
    var icon: String
    var title: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            TextField(title, text: $text)
                .keyboardType(keyboard)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(8)
        }
        .padding(.horizontal)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
