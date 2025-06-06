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
        ZStack{
            Color.white
                .ignoresSafeArea()
        ScrollView {
            HStack {
                Image("humenUi") // Add your cartoon image to Assets
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Gender")
                        .font(.headline)
                    
                    HStack {
                        GenderButton(label: "Male", isSelected: gender == "Male") {
                            gender = "Male"
                        }
                        GenderButton(label: "Female", isSelected: gender == "Female") {
                            gender = "Female"
                        }
                    }
                    
                    InfoInputField(title: "Age", value: $age, suffix: "")
                    InfoInputField(title: "Height", value: $height, suffix: "cm")
                    InfoInputField(title: "Weight", value: $weight, suffix: "lbs")
                }
                .padding(.horizontal)
            }
            .padding(.top)
            Spacer()
            
            VStack{
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

struct GenderButton: View {
    var label: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: label == "Male" ? "person.fill" : "person.fill.viewfinder")
                Text(label)
            }
            .padding(12)
            .frame(width: 95)
            .font(.system(size: 13))
            .background(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
        .foregroundColor(isSelected ? .blue : .gray)
    }
}

struct InfoInputField: View {
    var title: String
    @Binding var value: String
    var suffix: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                TextField(title, text: $value)
                    .keyboardType(.decimalPad)
                    .frame(height: 40)
                
                Text(suffix)
                    .foregroundColor(.blue)
                    .padding(.trailing, 8)
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}
