//
//  Habit.swift
//  HabitTracker
//
//  Created by Bartosz Rola on 23/02/2023.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int = 0
}
