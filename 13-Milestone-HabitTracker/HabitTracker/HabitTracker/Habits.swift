//
//  Habits.swift
//  HabitTracker
//
//  Created by Bartosz Rola on 23/02/2023.
//

import Foundation

class Habits: ObservableObject {
    @Published var habitsList = [Habit]() {
        didSet {
            let endcoder = JSONEncoder()
            
            if let encoded = try? endcoder.encode(habitsList) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habitsList = decodedHabits
                return
            }
        }
            
        habitsList = []
    }
}
