//
//  ImageView.swift
//  RockPaperScissors
//
//  Created by Bartosz Rola on 30/09/2022.
//

import SwiftUI

struct ImageView: View {
    let name: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 5)
                )
                .shadow(color: .black, radius: 2, x: 0, y: 0)
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(5)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "Paper")
    }
}
