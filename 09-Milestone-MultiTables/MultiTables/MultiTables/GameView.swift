//
//  GameView.swift
//  MultiTables
//
//  Created by Bartosz Rola on 05/10/2022.
//

import SwiftUI

struct GameView: View {
    let questions: Questions
    @Binding var gameActive: Bool
    
    @State private var numberOfQuestion = 0
    @State private var score = 0
    
    @State private var gameOver = false
    @State private var resultAlert = false
    
    @State private var resultTile = ""
    @State private var resultMessage = ""
    
    @State private var firstChar = true
    @State private var answer = "0"
    
    var answerInt: Int {
        if let tempInt = Int(answer) {
            return tempInt
        }
        return 0
    }
    
    let buttonColors = [
        Color(red: 0.9921, green: 0.4784, blue: 0.4431), // 1 Button
        Color(red: 0.9921, green: 0.6117, blue: 0.4431), // 2 Button
        Color(red: 0.9921, green: 0.8313, blue: 0.4431), // 3 Button
        Color(red: 0.8314, green: 0.8353, blue: 0.4509), // 4 Button
        Color(red: 0.6313, green: 0.8392, blue: 0.4431), // 5 Button
        Color(red: 0.6353, green: 0.8353, blue: 0.7058), // 6 Button
        Color(red: 0.6353, green: 0.8353, blue: 0.9608), // 7 Button
        Color(red: 0.6, green: 0.7098, blue: 0.9608), // 8 Button
        Color(red: 0.8980, green: 0.6509, blue: 1), // 9 Button
        Color(red: 0.7568, green: 0.7804, blue: 1) // 0 Button
    ]
    
    var body: some View {
        ZStack {
            Color(red: 177/255, green: 160/255, blue: 235/255)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("\(questions.questions[numberOfQuestion].0)")
                    .font(.title)
                    .fontWeight(.bold)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 60)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 5)
                        )
                    
                    HStack {
                        Spacer()
                        Text(answer)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding()
                }
                
                
                VStack {
                    HStack {
                        Spacer()
                        ForEach(1..<4) { number in
                            Button(action: {
                                enterNumButton(number: "\(number)")
                            }, label: {
                                NumberButton(text: "\(number)", color: buttonColors[number-1])
                            })
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Spacer()
                        ForEach(4..<7) { number in
                            Button(action: {
                                enterNumButton(number: "\(number)")
                            }, label: {
                                NumberButton(text: "\(number)", color: buttonColors[number-1])
                            })
                            Spacer()
                        }
                        
                    }
                    
                    HStack {
                        Spacer()
                        ForEach(7..<10) { number in
                            Button(action: {
                                enterNumButton(number: "\(number)")
                            }, label: {
                                NumberButton(text: "\(number)", color: buttonColors[number-1])
                            })
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            eraseAnswer()
                        }, label: {
                            NumberButton(text: "×", color: .red)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            enterNumButton(number: "0")
                        }, label: {
                            NumberButton(text: "0", color: buttonColors[9])
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            enterAnswer()
                        }, label: {
                            NumberButton(text: "✓", color: .green)
                        })
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Text("Question \(numberOfQuestion+1) of \(questions.questionsAmount)")
                    .font(.headline)
                
                Text("Score: \(score)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
        }
        .transition(.scale)
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Continue") {
                withAnimation {
                    gameActive = false
                }
            }
        } message: {
            Text("Your final score is \(score)!")
        }
        .alert(resultTile, isPresented: $resultAlert) {
            
        } message: {
            Text(resultMessage)
        }
        
    }
    
    func enterAnswer() {
        if answerInt == questions.questions[numberOfQuestion].1 {
            score += 1
            resultTile = "Correct!"
            resultMessage = "Your score is \(score)"
        } else {
            resultTile = "Wrong!"
            resultMessage = "It's \(questions.questions[numberOfQuestion].1)"
        }
        
        resultAlert = true
        eraseAnswer()
        
        if numberOfQuestion == questions.questionsAmount-1 {
            gameOver = true
            return
        }
        
        numberOfQuestion += 1
    }
    
    func enterNumButton(number: String) {
        if firstChar {
            answer = number
            firstChar = false
        } else if answer.count < 5 {
            answer+=number
        } else {
            return
        }
    }
    
    func eraseAnswer() {
        answer = "0"
        firstChar = true
    }
}


struct GameView_Previews: PreviewProvider {
    static var isActive = true
    
    static var previews: some View {
        GameView(questions: Questions(questionsAmount: 10, upTo: 10), gameActive: .constant(true))
    }
}

