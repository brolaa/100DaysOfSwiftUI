//
//  Table.swift
//  MultiTables
//
//  Created by Bartosz Rola on 05/10/2022.
//

import Foundation

struct Questions {
    let questionsAmount: Int
    let upTo: Int
    
    let questions: [(String, Int)]
    
    init (questionsAmount: Int, upTo: Int) {
        self.questionsAmount = questionsAmount
        self.upTo = upTo
        
        var questions = [(String, Int)]()
        
        for _ in (0..<questionsAmount) {
            let num1 = Int.random(in: 0...upTo)
            let num2 = Int.random(in: 0...upTo)
            
            let question = "What is \(num1) × \(num2)?"
            let answer = num1 * num2
            
            let pair = (question: question, answer: answer)
            
            questions.append(pair)
        }
        
        self.questions = questions
    }
}
