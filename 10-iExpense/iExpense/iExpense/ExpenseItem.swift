//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Bartosz Rola on 15/02/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
