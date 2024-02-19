//
//  ContentView.swift
//  Flashzilla
//
//  Created by Bartosz Rola on 27/07/2023.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var cards = [Card]()
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhane
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card, removal: {
                            withAnimation {
                                removeCard()
                            }
                        }, putBack: {
                            withAnimation {
                                putBack(card: card)
                            }
                        })
                        .stacked(at: getIndex(of: card), in: cards.count)
                        .allowsHitTesting(frontCard(card))
                        .accessibilityHidden(backCard(card))
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .padding()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                putBack(card: cards.last)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                removeCard()
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { timer in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhane) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
    }
    
    func removeCard() {
        guard !cards.isEmpty else { return }
        
        cards.removeLast()
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        cards = FileManager.loadData(savePath: savePath)
        //loadData()
    }
    
    func putBack(card: Card?) {
        guard let card = card else { return }
        
        removeCard()
                
        let cardCopy = Card(prompt: card.prompt, answer: card.answer)
        
        cards.insert(cardCopy, at: 0)
    }
    
    func getIndex(of card: Card) -> Int {
        guard let index = cards.firstIndex(where: { $0.id == card.id })  else {
            fatalError("No index found!")
        }
        return index
    }
    
    func frontCard(_ card: Card) -> Bool {
        guard let lastCard = cards.last else {
            return false
        }
        
        if card.id == lastCard.id {
            return true
        }
        
        return false
    }
    
    func backCard(_ card: Card) -> Bool {
        guard let lastCard = cards.last else {
            return false
        }
        
        if card.id != lastCard.id {
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* Card stack with indexes
 ZStack {
     ForEach(0..<cards.count, id: \.self) { index in
         CardView(card: cards[index]) {
             withAnimation {
                 removeCard(at: index)
             }
         }
         .stacked(at: index, in: cards.count)
         .allowsHitTesting(index == cards.count - 1)
         .accessibilityHidden(index < cards.count - 1)
     }
 }
 .allowsHitTesting(timeRemaining > 0)
 */

/* removing card with indexes
 func removeCard(at index: Int) {
     guard index >= 0 else { return }
     
     cards.remove(at: index)
     
     if cards.isEmpty {
         isActive = false
     }
 }
 */

/* loading data with Documents folder
 func loadData() {
     print("loading stated")
     
     if let data = try? Data(contentsOf: savePath) {
         print("data found")
         if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
             print("data decoded")
             cards = decoded
         }
     }
 }
 */
