//
//  loginScreen.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import CoreData

struct loginScreen: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""

    @State private var navigateToProfile = false
    @State private var navigateToDetails = false

    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        Image("backgroundImage")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(15)
                            .frame(width: 200, height: 200)
                            
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 2))
//                            .shadow(radius: 10)
                            .padding(.top, 40)
                            .cornerRadius(15)

//                        Text("Welcome Back!")
//                            .font(.largeTitle.bold())
//                            .foregroundColor(.white)

                        Text("Login to continue your fitness journey.")
                            .font(.subheadline)
                            .bold()
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))

                        VStack(spacing: 18) {
                            CustomTextField(icon: "person.fill", placeHolder: "Username", text: $userName)
                            CustomTextField(icon: "envelope.fill", placeHolder: "Email", text: $email)
                            CustomTextField(icon: "lock.fill", placeHolder: "Password", text: $password)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(25)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                        VStack(spacing: 14) {
                            NavigationLink(destination: DetailFormView(), isActive: $navigateToDetails) {
                                Button(action: {
                                    navigateToDetails = true
                                }) {
                                    Text("Add Details")
                                        .frame(width: 240)
                                        .padding()
                                        .bold()
//                                        .background(LinearGradient(colors: [Color.orange, Color.red], startPoint: .top, endPoint: .bottom))
                                        .background(Color.purple.opacity(0.7))
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .cornerRadius(16)
                                }
                            }

                            NavigationLink(destination: MainTabView().environment(\.managedObjectContext, viewContext), isActive: $navigateToProfile) {
                                EmptyView()
                            }

                            Button(action: {
                                saveUser()
                            }) {
                                Text("Login")
                                    .frame(width: 240)
                                    .padding()
                                    .bold()
//                                    .background(LinearGradient(colors: [Color.blue, Color.indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .background(Color.blue.opacity(0.7))
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
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

        let user = users.first ?? User(context: viewContext)
        user.userName = userName
        user.email = email

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

