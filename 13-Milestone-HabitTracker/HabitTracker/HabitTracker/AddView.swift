//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Bartosz Rola on 23/02/2023.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                TextField("Description", text: $description)
            }
            .navigationTitle("Add Habit")
            .toolbar {
                Button("Save") {
                    let habit = Habit(name: name, description: description)
                    habits.habitsList.append(habit)
                    dismiss()
                }
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
