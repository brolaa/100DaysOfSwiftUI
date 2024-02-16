//
//  NumOfQuestionsButton.swift
//  MultiTables
//
//  Created by Bartosz Rola on 31/10/2022.
//

import SwiftUI

struct NumOfQuestionsButton: View {
    let text: String
    @Binding var isHighlighted: Bool
    
    let highlightColor = Color(red: 0.9647, green: 0.8901, blue: 0.4588)
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isHighlighted ? highlightColor : .white)
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

struct NumOfQuestionsButton_Previews: PreviewProvider {
    static var previews: some View {
        NumOfQuestionsButton(text: "5", isHighlighted: .constant(true))
    }
}
