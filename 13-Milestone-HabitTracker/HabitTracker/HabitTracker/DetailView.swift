//
//  DetailView.swift
//  HabitTracker
//
//  Created by Bartosz Rola on 23/02/2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var habits: Habits
    @State var habit: Habit
    
    var body: some View {
        List {
            Section("Description") {
                Text(habit.description)
            }
            
            Section {
                Text("Completed \(habit.count) " + (habit.count == 1 ? "time" : "times"))
            }
            
            Section {
                Button {
                    incrementCompletion()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                           
                        HStack {
                            Spacer()
                            Text("Complete")
                                .foregroundColor(.white)
                                .font(.headline)
                            Spacer()
                        }
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .listRowBackground(Color.clear)
            
            
        }
        .navigationTitle(habit.name)
    }
    
    func incrementCompletion() {
        habit.count += 1
        
        if let index = habits.habitsList.firstIndex(where: {$0.id == habit.id}) {
            habits.habitsList[index].count = habit.count
        } else {
            fatalError("Cannot find \(habit.name) in habits array")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let habits = Habits()
    static let habit = habits.habitsList[0]
    
    static var previews: some View {
        DetailView(habits: Habits(), habit: habit)
    }
    
    
}
