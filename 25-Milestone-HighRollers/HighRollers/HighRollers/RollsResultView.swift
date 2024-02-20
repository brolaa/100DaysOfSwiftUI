//
//  RollsResultView.swift
//  HighRollers
//
//  Created by Bartosz Rola on 22/08/2023.
//

import SwiftUI

struct RollsResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingRemoveDialog = false
    
    @Binding var rolls: [Roll]
    
    var rollsSorted: [Roll] {
        return rolls.reversed()
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Rolls")
    
    var body: some View {
        NavigationView {
            List(rollsSorted) { roll in
                VStack(alignment: .leading) {
                    Text(" \(roll.sides)-sided, \(roll.amount) dice")
                        .foregroundColor(.secondary)
                    
                    Text("Results:")
                    NumberListView(numbers: roll.numbers)
                    
                    Text("Total: \(roll.total)")
                        .font(.headline)
                }
            }
            .navigationTitle("Results")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear", action: toggleRemoveDialog)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: done)
                }
            }
            .confirmationDialog("Remove all previous rolls?", isPresented: $showingRemoveDialog, titleVisibility: .visible) {
                Button("Yes", role: .destructive, action: removeRolls)
            }
        }
    }
    
    func toggleRemoveDialog() {
        showingRemoveDialog = true
    }
    
    func removeRolls() {
        rolls.removeAll()
        FileManager.saveData(savePath: savePath, data: rolls)
    }
    
    func done() {
        dismiss()
    }
}

struct RollsResultView_Previews: PreviewProvider {
    static var previews: some View {
        RollsResultView(rolls: .constant([Roll](repeating: Roll.example, count: 5)))
    }
}
