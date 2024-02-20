//
//  DiceView.swift
//  HighRollers
//
//  Created by Bartosz Rola on 21/08/2023.
//

import SwiftUI

struct DiceView: View {
    let number: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 4)
            Text("\(number)")
                .font(.largeTitle)
                .foregroundColor(.black)
                .fontWeight(.bold)
        }
        .frame(width: 100, height: 100)
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(number: 4)
    }
}
