//
//  Roll.swift
//  HighRollers
//
//  Created by Bartosz Rola on 21/08/2023.
//

import Foundation

struct Roll: Codable, Identifiable {
    var id = UUID()
    let sides: Int
    let amount: Int
    let total: Int
    var numbers = [Int]()
    
    static let example = Roll(sides: 6, amount: 2, total: 7, numbers: [3, 4])
}
