//
//  HealthManager.swift
//  healthKitAPP
//
//  Created by Paranjothi iOS MacBook Pro on 04/06/25.
//


import Foundation
import HealthKit
import CoreData

@MainActor
class HealthManager: ObservableObject {
    private let healthStore = HKHealthStore()
        
//    let healthStore = HKHealthStore()

       @Published var calories: Double = 0
       @Published var steps: Int = 0
       @Published var workoutDuration: Double = 0
       @Published var progress: Double = 0.0

       var context: NSManagedObjectContext?
    



//    var progress: Double {
//        min((calories / 500.0 + Double(steps) / 10000.0 + workoutDuration / 3600.0) / 3.0, 1.0)
//    }

    func requestAuthorization() {
            let read = Set([
                HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                HKObjectType.quantityType(forIdentifier: .stepCount)!
            ])

            healthStore.requestAuthorization(toShare: [], read: read) { success, error in
                if success {
                    self.fetchTodayWorkout()
                }
            }
        }

        func fetchTodayWorkout() {
            // Simulate fetching steps & calories from HealthKit
            DispatchQueue.main.async {
                self.steps = 8500
                self.calories += 100 // For example
                self.progress = min(Double(self.steps) / 10000.0, 1.0)
            }
        }

        func updateProgressFromCoreData(context: NSManagedObjectContext) {
            self.context = context

            let request: NSFetchRequest<Workout> = Workout.fetchRequest()
            request.predicate = NSPredicate(format: "isCompleted == YES")

            do {
                let completedWorkouts = try context.fetch(request)

                let totalCalories = completedWorkouts.reduce(0) { $0 + $1.calories }
                let totalDuration = completedWorkouts.reduce(0) { $0 + $1.duration }

                DispatchQueue.main.async {
                    self.calories = totalCalories
                    self.workoutDuration = totalDuration
                }
            } catch {
                print("Error fetching workouts: \(error)")
            }
        }
    
    
//    func requestAuthorization() {
//        guard HKHealthStore.isHealthDataAvailable() else { return }
//
//        let readTypes: Set<HKObjectType> = [
//            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKObjectType.quantityType(forIdentifier: .stepCount)!,
//            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!
//        ]
//
//        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
//            if success {
//                print("Authorized")
//            } else if let error = error {
//                print("Auth error: \(error)")
//            }
//        }
//    }

//    func fetchTodayWorkout() {
//        let startOfDay = Calendar.current.startOfDay(for: Date())
//
//        fetchQuantity(.stepCount, unit: .count(), from: startOfDay) { value in
//            self.steps = Int(value)
//        }
//
//        fetchQuantity(.activeEnergyBurned, unit: .kilocalorie(), from: startOfDay) { value in
//            self.calories = value
//        }
//
//        fetchQuantity(.appleExerciseTime, unit: .minute(), from: startOfDay) { value in
//            self.workoutDuration = value * 60
//        }
//    }

    private func fetchQuantity(_ identifier: HKQuantityTypeIdentifier, unit: HKUnit, from startDate: Date, completion: @escaping (Double) -> Void) {
        guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
            completion(0)
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            let value = result?.sumQuantity()?.doubleValue(for: unit) ?? 0
            DispatchQueue.main.async {
                completion(value)
            }
        }

        healthStore.execute(query)
    }

    func saveWorkout(context: NSManagedObjectContext) {
        let workout = Workout(context: context)
        workout.date = Date()
        workout.calories = calories
        workout.steps = Int64(steps)
        workout.duration = workoutDuration

        do {
            try context.save()
            print("Workout saved.")
        } catch {
            print("Save error: \(error)")
        }
    }
    
//    func updateProgressFromCoreData(context: NSManagedObjectContext) {
//        let request: NSFetchRequest<Workout> = Workout.fetchRequest()
//        do {
//            let allWorkouts = try context.fetch(request)
//            let total = allWorkouts.count
//            let completed = allWorkouts.filter { $0.isCompleted }.count
//
//            DispatchQueue.main.async {
//                self.progress = total > 0 ? Double(completed) / Double(total) : 0.0
//            }
//        } catch {
//            print("Error fetching workouts: \(error)")
//        }
//    }


}
