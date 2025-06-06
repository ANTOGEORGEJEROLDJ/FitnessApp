import SwiftUI
import CoreData

struct WorkoutTaskView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var healthManager: HealthManager
    @Environment(\.presentationMode) var presentationMode

    var workout: Workout
    @State private var navigateToHistory = false
    @State private var showSuccess = false

    var body: some View {
//        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Hero Image
                    ZStack {
                        Image(imageForWorkout(title: workout.title ?? ""))
                            .resizable()
                            .frame(width: 400, height: 280)
                            .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                            .shadow(radius: 10)
                    }
                    
                    Text(workout.title ?? "Workout")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)

                    // Info Cards
                    HStack(spacing: 20) {
                        InfoCardView(icon: "clock", label: "Duration", value: formatDuration(workout.duration))
                        InfoCardView(icon: "flame.fill", label: "Calories", value: "\(Int(workout.calories)) kcal")
                        InfoCardView(icon: "calendar", label: "Date", value: formattedDate(workout.date))
                    }
                    .padding(.horizontal)

                    // Workout Instructions
                    VStack(alignment: .leading, spacing: 16) {
                        if let title = workout.title {
                            WorkoutDetailsView(title: title)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.horizontal)

                    // Mark as Completed Button
                    Button(action: {
                        workout.isCompleted = true
                        saveContext()
                        healthManager.updateProgressFromCoreData(context: context)
                        navigateToHistory = true
                    }) {
                        Text("✅ Mark as Completed")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(radius: 6)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)

                    NavigationLink(destination: WorkoutHistoryView(), isActive: $navigateToHistory) {
                        EmptyView()
                    }
                }
                .padding(.top)
                .alert("Workout Completed 🎉", isPresented: $showSuccess) {
                    Button("OK") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
//        }
        .navigationBarTitle("Workout Details", displayMode: .inline)
        .navigationBarBackButtonHidden()
    }

    // MARK: - Utility Functions
    func saveContext() {
        withAnimation {
            do {
                try context.save()
                showSuccess = true
            } catch {
                print("Error saving: \(error)")
            }
        }
    }

    func formattedDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    func formatDuration(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d mins", minutes, seconds)
    }

    func imageForWorkout(title: String) -> String {
        switch title {
        case "10 Push-ups": return "pushups"
        case "15 min Yoga": return "yoga"
        case "Plank 1 min": return "plank"
        case "Jump Rope 200x": return "jumpropeimag"
        default: return "running"
        }
    }
}

// MARK: - InfoCardView
struct InfoCardView: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding(12)
                .background(Circle().fill(Color.blue))
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 12))
                .bold()
        }
        .padding()
        .frame(width: 110)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
