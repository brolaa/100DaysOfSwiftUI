//
//  ContentView.swift
//  MultiTables
//
//  Created by Bartosz Rola on 05/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State var numberOfQuestion = 10
    @State var upTo = 5
    @State var gameActive = false
    
    var body: some View {
        if !gameActive {
            MenuView(numberOfQuestion: $numberOfQuestion, upTo: $upTo, gameActive: $gameActive)
        } else {
            GameView(questions: Questions(questionsAmount: numberOfQuestion, upTo: upTo), gameActive: $gameActive)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
