//
//  WorkoutDetailsView.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 06/06/25.
//

import SwiftUI
import CoreData

// MARK: - Workout Details Component
struct WorkoutDetailsView: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch title {
            case "10 Push-ups":
                Text("💪 Push-ups Instructions")
                    .font(.headline)
                    .foregroundColor(.purple)
//                    .shadow(radius: 3)
                
                VStack{
                Text("""
                                                                - Start in a plank position with hands under shoulders.
                                                                - Lower your body until your chest nearly touches the floor.
                                                                - Push back up and repeat.
                                                                """)
            }
            .padding()
//            .background(Color.purple.opacity(0.1))
            .cornerRadius(10)
//            .shadow(radius: 3)
                
                Text("Benefits:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.purple)
                
                VStack{
                    Text("""
                - Strengthens chest, triceps, and core.
                - Improves posture and endurance.
                """)
                }
                .padding()
//                .background(.ultraThinMaterial)
                .cornerRadius(10)
//                .shadow(radius: 3)
                
                
            case "15 min Yoga":
                Text("🧘 Yoga Routine")
                    .font(.headline)
                    .foregroundColor(.purple)
                
                VStack{
                    
                Text("""
                                                - 5 mins: Breathing & centering
                                                - 5 mins: Sun salutations & poses
                                                - 5 mins: Meditation & cooldown
                                                """)
            }
            .padding()
//            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
//            .shadow(radius: 3)
            
                Text("Benefits:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.purple)
                
                VStack{
                Text("""
                - Increases flexibility
                - Reduces anxiety and stress
                - Enhances focus and relaxation
                """)
            }
            .padding()
//            .background(.ultraThinMaterial)
            .cornerRadius(10)
//            .shadow(radius: 3)
             
                
            case "Plank 1 min":
                Text("🧍 Plank Instructions")
                    .font(.headline)
                    .foregroundColor(.purple)
                
                VStack{
                Text("""
                                                - Keep forearms and toes on the floor, back straight.
                                                - Tighten your abs and hold the position.
                                                """)
                }
                .padding()
//                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)
//                .shadow(radius: 3)
                
                Text("Benefits:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.purple)
                
                VStack{
                    
                Text("""
                - Builds core strength
                - Improves balance and endurance
                - Tones abs and back
                """)
                }
                .padding()
//                .background(.ultraThinMaterial)
                .cornerRadius(10)
//                .shadow(radius: 5)
               
                
            case "Jump Rope 200x":
                Text("🤸 Jump Rope Routine")
                    .font(.headline)
                    .foregroundColor(.purple)
                
                VStack{
                Text("""
                                                - Use a rope of suitable length.
                                                - Keep elbows close to body and rotate wrists.
                                                - Jump just high enough to clear the rope.
                                                - Perform 200 repetitions.
                                                """)
            }
            .padding()
            
            .cornerRadius(10)
//            .shadow(radius: 3)
            
                Text("Benefits:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.purple)
                
                VStack{
                    
                Text("""
                - Burns fat quickly
                - Improves coordination and stamina
                - Fun cardio workout
                """)
            }
            .padding()
//            .background(.ultraThinMaterial)
            .cornerRadius(10)
//            .shadow(radius: 3)
                
                
            default:
                Text("ℹ️ General Info")
                    .font(.headline)
                    .foregroundColor(.purple)
                
                VStack{
                Text("""
                                                - Wear comfortable running shoes with good cushioning                                                - Warm up with light stretches or a brisk 5-minute walk.
                                                - Maintain a steady pace throughout the run (don’t sprint early.
                                                - Focus on posture: head up, shoulders relaxed, and arms swinging naturally
                                          """)
                }
                .font(.system(size: 15))
                .padding()
                .cornerRadius(10)

                
                
                    Text("Benefits:")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.purple)
                    
                    VStack{
                        
                    Text("""
                    - Enhances cardiovascular health
                    - Burns calories and aids weight loss
                    - Builds mental endurance and discipline
                    """)
                }
                .padding()
    //            .background(.ultraThinMaterial)
                .cornerRadius(10)
            }
        }
        .padding(.top)
    }
}
