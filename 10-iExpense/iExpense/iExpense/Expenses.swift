//
//  Expenses.swift
//  iExpense
//
//  Created by Bartosz Rola on 15/02/2023.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
            
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func getExpensesForType(_ type: String) -> [ExpenseItem] {
        items.filter {
            $0.type == type
        }
    }
    
    func removeExpense(offsets: IndexSet, type: String) {
        for offset in offsets {
            let id = getExpensesForType(type)[offset].id
            guard let index = items.firstIndex(where: {$0.id == id}) else {
                fatalError("No index found!")
            }
            items.remove(at: index)
        }
    }
}
