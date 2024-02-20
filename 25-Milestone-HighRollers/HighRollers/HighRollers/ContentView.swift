//
//  ContentView.swift
//  HighRollers
//
//  Created by Bartosz Rola on 21/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var sides = 6
    @State private var amount = 1
    @State private var numbers = [Int]()
    
    @State private var showingCustomizeSheet = false
    @State private var showingResultsSheet = false
    
    @State private var rolls = [Roll]()
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var total: Int {
        var sum = 0
        for num in numbers {
            sum += num
        }
        return sum
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Rolls")
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if numbers.count == 1 {
                        VStack {
                            DiceView(number: numbers[0])
                                .padding()
                        }
                        .padding()
                    } else {
                        LazyVGrid(columns: columns) {
                            ForEach(0..<numbers.count, id: \.self) { ind in
                                DiceView(number: numbers[ind])
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
                
                VStack {
                    Text("Total: \(total)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button {
                        rollDice()
                    } label: {
                        Text("Roll")
                            .frame(width: 150, height: 60)
                            .background(.blue)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("HighRollers")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Results") {
                        showingResultsSheet = true
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Customize") {
                        showingCustomizeSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingCustomizeSheet) {
                CustomizeDiceView(sides: $sides, amount: $amount, onClose: drawDice)
            }
            .sheet(isPresented: $showingResultsSheet) {
                RollsResultView(rolls: $rolls)
            }
            .onAppear {
                drawDice()
                preloadData()
            }
        }
    }
    
    func drawDice() {
        numbers.removeAll()
        
        for _ in (1...amount) {
            let num = Int.random(in: 1...sides)
            numbers.append(num)
        }
    }
    
    func rollDice() {
        feedback.prepare()
        
        var timer = Timer()
        var counter = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if counter < 10 {
                counter += 1
                drawDice()
            } else {
                
                let roll = Roll(sides: sides, amount: amount, total: total, numbers: numbers)
                rolls.append(roll)
                
                FileManager.saveData(savePath: savePath, data: rolls)
                timer.invalidate()
            }
        }
        
        feedback.notificationOccurred(.success)
        
    }
    
    func preloadData() {
        rolls = FileManager.loadData(savePath: savePath)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
