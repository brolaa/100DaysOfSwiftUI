//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Bartosz Rola on 30/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var playerScore = 0
    @State private var roundNumber = 0
    
    @State private var showResult = false
    @State private var gameOver = false
    
    @State private var resultTitle = ""
    @State private var resultMessage = ""
    
    @State private var animationAmount = 0.0
    @State private var tappedIndex = 0

    let choices = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
   
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.74, green: 0.85, blue: 1), Color(red: 0.96, green: 0.71, blue: 1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Image("logoRPS")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 100, alignment: .center)
                    .padding(.bottom)
                    .shadow(color: .black, radius: 1, x: 0, y: 0)
                
                VStack {
                    Text("Computer chose \(choices[computerChoice].lowercased()).")
                        .secondaryTitle()
                        .padding(.bottom)
                    
                    Text("You should:")
                        .mainTitle()
                    
                    Text(shouldWin ? "Win" : "Lose")
                        .font(.largeTitle.bold())
                        .foregroundColor(shouldWin ? .blue : .red)
                        .shadow(color: .black, radius: 1, x: 0, y: 0)
                }
                
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            tappedIndex = number
                            withAnimation {
                                playerChoice(number)
                            }
                        } label: {
                            ImageView(name: choices[number])
                        }
                        .rotation3DEffect(.degrees(number == tappedIndex ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .secondaryTitle()
                
                Spacer()
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showResult) {
            Button("Continue", action: newChoice)
        } message: {
            Text(resultMessage)
        }
        .alert("Game over", isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(playerScore)")
        }
    }
    
    func playerChoice(_ choice: Int) {
        animationAmount += 360
        
        if shouldWin {
            if (choices[choice] == winningMoves[computerChoice]) {
                result(won: true)
            } else {
                result(won: false)
            }
        } else {
            if (choices[choice] != winningMoves[computerChoice] && choices[choice] != choices[computerChoice]) {
                result(won: true)
            } else {
                result(won: false)
            }
        }
        
        roundNumber += 1
        
        showResult = true
        
        if roundNumber == 10 {
            gameOver = true
        }
    }
    
    func result(won: Bool) {
        if won {
            playerScore += 1
            resultTitle = "Correct"
            resultMessage = "You've scored a point!"
        } else {
            playerScore -= 1
            resultTitle = "Wrong"
            resultMessage = "You've lost a point!"
        }
    }
    
    func newChoice() {
        computerChoice = Int.random(in: 0...2)
        shouldWin.toggle()
        animationAmount = 0
    }
    
    func reset() {
        playerScore = 0
        roundNumber = 0
        newChoice()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
