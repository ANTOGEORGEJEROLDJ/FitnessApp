//
//  loginScreen.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//

import SwiftUI
import CoreData
import GoogleSignInSwift
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import AuthenticationServices

struct loginScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private let appleLoginManager = AppleSignInManager()
    
    @State private var isSignedIn = false
    @State private var errorMessage = "" 
    
    @State private var userName = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var navigateToProfile = false
    @State private var navigateToDetails = false
    
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            ZStack {
                
                //                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.4)]),
                //                               startPoint: .topLeading,
                //                               endPoint: .bottomTrailing)
                //                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        VStack{
                            Image("backgroundImage")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .frame(width: 200, height: 200)
                                .padding(.top, 40)
                                .cornerRadius(15)
                            
                            
                            Text("Login to continue your fitness journey.")
                                .font(.subheadline)
                                .bold()
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Group{
                            VStack(spacing: 18) {
                                CustomTextField(icon: "person.fill", placeHolder: "Username", text: $userName)
                                CustomTextField(icon: "envelope.fill", placeHolder: "Email", text: $email)
                                CustomTextField(icon: "lock.fill", placeHolder: "Password", text: $password)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(25)
                            .padding(.horizontal)
                            .shadow(radius: 0.3)
                            .padding(.top,-30)
                            
                        }
                        VStack(spacing: 14) {
                            NavigationLink(destination: DetailFormView(), isActive: $navigateToDetails) {
                                Button(action: {
                                    navigateToDetails = true
                                }) {
                                    Text("Add Details")
                                        .frame(width: 258, height: 22)
                                        .padding()
                                        .bold()
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(.headline)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                                }
                            }
                            
                            NavigationLink(destination: MainTabView().environment(\.managedObjectContext, viewContext), isActive: $navigateToProfile) {
                                EmptyView()
                            }
                            
                            Button(action: {
                                saveUser()
                            }) {
                                Text("Login")
                                    .frame(width: 258, height: 22)
                                    .padding()
                                    .bold()
                                    .background(Color.blue.opacity(0.2))
                                    .foregroundColor(.black.opacity(0.7))
                                    .font(.headline)
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            }
                        }
                            .padding(.horizontal)
                            .padding(.bottom, 40)
                        
                        
                        HStack (spacing: 20){
                            Button(action: {
                                
                                handleGoogleSignIn()
                            }){
                                Image("google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 19, height: 19)
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue.opacity(0.1))
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                            
                            Button(action:{
                                
                                appleLoginManager.startSignInWithAppleFlow()
                                
                            }){
                                Image("apple")
                                    .resizable()
                                    .scaledToFit()
                                
                            }
                            .frame(width: 70, height: 22)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue.opacity(0.1))
                            .font(.headline)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }.padding(.top, -30)
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
    
    // MARK: - Google Sign-In
        func handleGoogleSignIn() {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootVC = windowScene.windows.first?.rootViewController else {
                return
            }

            GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
                if let error = error {
                    print("❌ Google Sign-In failed: \(error.localizedDescription)")
                    return
                }

                guard let result = result,
                      let idToken = result.user.idToken?.tokenString else { return }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: result.user.accessToken.tokenString)

                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("❌ Firebase Sign-In failed: \(error.localizedDescription)")
                    } else {
                        self.isSignedIn = true
                        print("✅ Google Sign-In Success: \(authResult?.user.email ?? "")")
                    }
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

