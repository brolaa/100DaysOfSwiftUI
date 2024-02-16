//
//  MenuView.swift
//  MultiTables
//
//  Created by Bartosz Rola on 05/10/2022.
//

import SwiftUI

struct MenuView: View {
    @Binding var numberOfQuestion: Int
    @Binding var upTo: Int
    @Binding var gameActive: Bool
    
    @State var isHighlighted5 = false
    @State var isHighlighted10 = true
    @State var isHighlighted20 = false
    
    @State var isGrayedOutPlus = false
    @State var isGrayedOutMinus = false
    
    
    
    var body: some View {
        ZStack {
            Color(red: 177/255, green: 160/255, blue: 235/255)
                .ignoresSafeArea()
            
            VStack {
                Image("logoMT")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100, alignment: .center)
                
                Spacer()
                
                VStack {
                    Text("Choose number of questions:")
                        .font(.headline)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            chooseNumOfQuestions(number: 5)
                        } label: {
                            NumOfQuestionsButton(text: "5", isHighlighted: $isHighlighted5)
                        }
                        
                        Spacer()
                        
                        Button {
                            chooseNumOfQuestions(number: 10)
                        } label: {
                            NumOfQuestionsButton(text: "10", isHighlighted: $isHighlighted10)
                        }
                        
                        Spacer()
                        
                        Button {
                            chooseNumOfQuestions(number: 20)
                        } label: {
                            NumOfQuestionsButton(text: "20", isHighlighted: $isHighlighted20)
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                    HStack {
                        Button {
                            upToButtonAction(increment: false)
                        } label: {
                            UpToButton(text: "minus", isGrayedOut: $isGrayedOutMinus)
                        }
                        .disabled(isGrayedOutMinus ? true : false)
                        
                        Text("Up to \(upTo)")
                            .font(.headline)
                            .padding()
                        
                        Button {
                            upToButtonAction(increment: true)
                        } label: {
                            UpToButton(text: "plus", isGrayedOut: $isGrayedOutPlus)
                        }
                        .disabled(isGrayedOutPlus ? true : false)
                    }
                    .padding()
                }
                
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.gameActive = true
                    }
                } label: {
                    StartGameButton()
                }
                
                Spacer()
                Spacer()
            
            }
            .padding()
            .transition(.scale)
            .onAppear{
                chooseNumOfQuestions(number: 10)
            }
        }
        
    }
    
    func chooseNumOfQuestions(number: Int) {
        isHighlighted5 = false
        isHighlighted10 = false
        isHighlighted20 = false
        
        switch number {
        case 5:
            isHighlighted5 = true
        case 10:
            isHighlighted10 = true
        default:
            isHighlighted20 = true
        }
        
        numberOfQuestion = number
    }
    
    func upToButtonAction(increment: Bool) {
        if increment {
            if upTo < 12 {
                isGrayedOutMinus = false
                upTo += 1
                if upTo == 12 {
                    isGrayedOutPlus = true
                }
            }
        } else {
            if upTo > 2 {
                isGrayedOutPlus = false
                upTo -= 1
                if upTo == 2 {
                    isGrayedOutMinus = true
                }
            }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(numberOfQuestion: .constant(10), upTo: .constant(10), gameActive: .constant(false))
    }
}

//Old code
/*
struct MenuView: View {
    /*
    @State private var numberOfQuestion = 5
    @State private var upTo = 6
    */
    @Binding var numberOfQuestion: Int
    @Binding var upTo: Int
    @Binding var gameActive: Bool
    
    let numberOfQuestions = [5, 10, 20]
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose number of questions:")
                
                Picker("Number of questions", selection: $numberOfQuestion) {
                    ForEach(numberOfQuestions, id: \.self) {
                        Text($0, format: .number)
                    }
                    
                    
                }
                .pickerStyle(.segmented)
                
                Stepper("Up to \(upTo)", value: $upTo, in: 2...12)
                
                /*
                NavigationLink(destination: GameView(questions: Questions(questionsAmount: numberOfQuestion, upTo: upTo), gameActive: $gameActive), isActive: $gameActive) {
                    EmptyView()
                }
                */
                Button("Start Game") {
                    self.gameActive = true
                    print(numberOfQuestion, upTo)
                }
                /*
                NavigationLink("Start Game", destination: GameView(questions: Questions(questionsAmount: numberOfQuestion, upTo: upTo), isActive: $showGame))
                 */
                /*
                Button(action: {
                /
                }, label: {
                    Text("Start Game")
                })
                 */
            }
            .navigationTitle("MultiTables")
        }
    }
        
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(numberOfQuestion: .constant(10), upTo: .constant(10), gameActive: .constant(false))
    }
}
*/

/*
     Picker("Number of questions", selection: $numberOfQuestion) {
         ForEach(numberOfQuestions, id: \.self) {
             Text($0, format: .number)
         }
         
     }
     .pickerStyle(.segmented)
 
 /*
Text(" \(upTo) \(numberOfQuestions) ")
    Stepper("Up to \(upTo)", value: $upTo, in: 2...12)
    
    
    //TODO: to nie zadziała ...
    NavigationLink(destination: GameView(questions: Questions(questionsAmount: numberOfQuestion, upTo: upTo), gameActive: $gameActive), isActive: $gameActive) {
        EmptyView()
    }
    */
 let numberOfQuestions = [5, 10, 20]

 */
