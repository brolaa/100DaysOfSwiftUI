//
//  ContentView.swift
//  HabitTracker
//
//  Created by Bartosz Rola on 23/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habitsList) {
                    habit in
                    NavigationLink { DetailView(habits: habits, habit: habit)
                    } label: {
                        HStack {
                            Text(habit.name)
                            
                            Spacer()
                            
                            Text("\(habit.count)")
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }

            }
            .sheet(isPresented: $showingAddHabit) {
                AddView(habits: habits)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.habitsList.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
