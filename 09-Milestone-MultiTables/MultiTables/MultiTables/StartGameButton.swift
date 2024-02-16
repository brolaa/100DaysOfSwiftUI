//
//  StartGameButton.swift
//  MultiTables
//
//  Created by Bartosz Rola on 31/10/2022.
//

import SwiftUI

struct StartGameButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.blue)
            
            Text("Start Game!")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.headline)
        }
        .frame(width: 140, height: 60, alignment: .center)
        
    }
}

struct StartGameButton_Previews: PreviewProvider {
    static var previews: some View {
        StartGameButton()
    }
}
