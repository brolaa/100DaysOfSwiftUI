//
//  EditCards.swift
//  Flashzilla
//
//  Created by Bartosz Rola on 29/07/2023.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                
                Section {
                    ForEach(cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: preloadData)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func preloadData() {
        cards = FileManager.loadData(savePath: savePath)
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newPrompt.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: newPrompt, answer: newAnswer)
        cards.insert(card, at: 0)
        FileManager.saveData(savePath: savePath, data: cards)
        
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        FileManager.saveData(savePath: savePath, data: cards)
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}

/* Load data using UserDefaults
func loadData() {
    if let data = UserDefaults.standard.data(forKey: "Cards") {
        if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
            cards = decoded
        }
    }
}
*/

/* Save data using UserDefaults
 if let data = try? JSONEncoder().encode(cards) {
     UserDefaults.standard.set(data, forKey: "Cards")
 }
 */

/* loading and saving data using documents folder
func loadData() {
    if let data = try? Data(contentsOf: savePath) {
        if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
            cards = decoded
        }
    }
}

func saveData() {
    if let data = try? JSONEncoder().encode(cards) {
        try? data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
    }
}
*/
