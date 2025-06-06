//
//  ContentView.swift
//  healthKitAPP
//
//  Created by Anto george jerold iOS MacBook Pro on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthManager
    @Environment(\.managedObjectContext) var context

    var body: some View {
        ZStack{
            Color.white
            NavigationView {
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("🏋️‍♂️ Workout Progress")
                        .font(.largeTitle.bold())
                    
                    
                    Text("BIM Info")
                        .font(.subheadline.bold())
                    
                    ProgressRing(progress: healthManager.progress)
                        .frame(width: 280, height: 300)
                    
                    VStack(spacing: 20) {
                        
                        
                        NavigationLink(destination: WorkoutListView()) {
                            Label("Workout List", systemImage: "list.bullet")
                                .modifier(FitnessButtonStyle(background: .orange))
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(colors: [.white, .blue.opacity(0.05)], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                )
            }
        }
    }
}
