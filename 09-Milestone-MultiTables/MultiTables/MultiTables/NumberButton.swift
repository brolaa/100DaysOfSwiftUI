//
//  NumberButton.swift
//  MultiTables
//
//  Created by Bartosz Rola on 04/11/2022.
//

import SwiftUI

struct NumberButton: View {
    let text: String
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 5)
                )
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                .frame(width: 70, height: 70, alignment: .center)
            Text(text)
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(text: "6", color: .white)
    }
}
