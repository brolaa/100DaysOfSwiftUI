//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bartosz Rola on 28/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameOver = false
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var gameOverMessage = ""
    
    @State private var playerScore = 0
    @State private var questionCounter = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var animationAmount = 0.0
    @State private var tappedIndex = 0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    @State private var wrongFlag = false
    @State private var correctFlag = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                        .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            tappedIndex = number
                            
                            withAnimation {
                               
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(country: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                               
                        }
                        .rotation3DEffect(.degrees(number == tappedIndex ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == tappedIndex ? 1.0 : opacityAmount)
                        .scaleEffect(number == tappedIndex ? 1.0 : scaleAmount)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(playerScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text(gameOverMessage + "Your score is \(playerScore).")
        }
    }
    
    
    func flagTapped(_ number: Int) {
       
        
        if number == correctAnswer {
            playerScore += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(playerScore)"
            
        } else {
            if playerScore > 0 {
                playerScore -= 1
            }
            scoreTitle = "Wrong"
            scoreMessage = "That’s the flag of \(countries[number]).\n Your score is \(playerScore)."
        }
        
        questionCounter += 1
        
        animationAmount += 360
        opacityAmount = 0.25
        scaleAmount = 0.8
        
        showingScore = true
        
        if questionCounter == 8 {
            judgePlayer(score: playerScore)
            gameOver = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
    
    func reset() {
        questionCounter = 0
        playerScore = 0
       
        askQuestion()
    }
    
    func judgePlayer(score: Int) {
        if playerScore == 8 {
            gameOverMessage = "Fantastic job! You've guessed all flags right!\n"
        } else if playerScore > 5 {
            gameOverMessage = "Great job!\n"
        } else if playerScore > 3 {
            gameOverMessage = "Nice job! You have a bit work to do.\n"
        } else {
            gameOverMessage = "Better luck next time! You have some work to do.\n"
        }
    }
}

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
