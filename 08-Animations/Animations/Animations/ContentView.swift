//
//  ContentView.swift
//  Animations
//
//  Created by Bartosz Rola on 02/10/2022.
//

import SwiftUI

//Creating implicit animations

struct ContentView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        //.scaleEffect(animationAmount)
        //.blur(radius: (animationAmount - 1) * 3)
        //.animation(.easeOut(duration: 2), value: animationAmount)
        //.animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        /*
         .animation(
             .easeInOut(duration: 2)
                 .delay(1),
             value: animationAmount
         )
         */
        /*
        .animation(
            .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true),
            value: animationAmount
        )
         */
        
        /*
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: true),
            value: animationAmount
        )
         */
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                           .easeOut(duration: 1)
                               .repeatForever(autoreverses: false),
                           value: animationAmount
                       )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
