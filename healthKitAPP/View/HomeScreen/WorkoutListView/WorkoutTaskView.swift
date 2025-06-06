import SwiftUI
import CoreData

struct WorkoutTaskView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var healthManager: HealthManager
    @Environment(\.presentationMode) var presentationMode

    var workout: Workout
    @State private var navigateToHistory = false

    var body: some View {
        VStack(spacing: 24) {
            Text(workout.title ?? "Workout")
                .font(.largeTitle.bold())
                .padding(.top)

            VStack(alignment: .leading, spacing: 12) {
                Text("🕒 Duration: \(formatDuration(workout.duration))")
                Text("🔥 Calories: \(Int(workout.calories)) kcal")
                Text("📅 Date: \(formattedDate(workout.date))")

                // Workout-specific details
                if let title = workout.title {
                    WorkoutDetailsView(title: title)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)

            Spacer()



            Button("Mark as Completed") {
                workout.isCompleted = true
                saveContext()
                healthManager.updateProgressFromCoreData(context: context)
                navigateToHistory = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationBarTitle("Workout Details", displayMode: .inline)
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving workout: \(error)")
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
}

