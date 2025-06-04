//
//  loginScreen.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import CoreData

// MARK: - Login Screen

struct loginScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var navigateToProfile = false
    @State private var navigateToDetails = false
    
    // Fetch existing user if any (show profile directly)
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("backgroundImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top)
                    
                    Text("Login to continue")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.5))
                    
                    VStack(spacing: 15) {
                        CustomTextField(icon: "person.fill", placeHolder: "UserName", text: $userName)
                        CustomTextField(icon: "envelope.fill", placeHolder: "Email", text: $email)
                        CustomTextField(icon: "lock.fill", placeHolder: "Password", text: $password)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        NavigationLink(destination: DetailFormView(), isActive: $navigateToDetails) {
                            Button("Add details") {
                                navigateToDetails = true
                            }
                            .frame(width: 258, height: 44)
                            .background(Color.red.opacity(0.6))
                            .foregroundColor(.white)
                            .font(.headline)
                            .bold()
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            .padding(.bottom, 10)
                        }
                        
                        NavigationLink(destination: MainTabView().environment(\.managedObjectContext, viewContext), isActive: $navigateToProfile) {
                            EmptyView()
                        }
                        
                        Button("Login") {
                            saveUser()
                        }
                        .frame(width: 258, height: 44)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .font(.headline)
                        .bold()
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        .padding(.bottom, 10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Login")
        }
        .onAppear {
            // If user exists, prefill username/email (optional)
            if let user = users.first {
                userName = user.userName ?? ""
                email = user.email ?? ""
            }
        }
    }
    
    private func saveUser() {
        guard !userName.isEmpty, !email.isEmpty else {
            print("Username and email cannot be empty")
            return
        }
        
        // Check if user exists, update or create new
        let user = users.first ?? User(context: viewContext)
        user.userName = userName
        user.email = email
        
        // If first time login, set defaults for others
        if user.age == 0 && user.gender == nil {
            user.age = 0
            user.gender = nil
            user.height = 0
            user.weight = 0
        }
        
        do {
            try viewContext.save()
            navigateToProfile = true
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
}

