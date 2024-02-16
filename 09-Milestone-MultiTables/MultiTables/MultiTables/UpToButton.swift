//
//  upToButton.swift
//  MultiTables
//
//  Created by Bartosz Rola on 31/10/2022.
//

import SwiftUI

struct UpToButton: View {
    let text: String
    @Binding var isGrayedOut: Bool
    
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 5)
                )
                .shadow(color: .black, radius: 2, x: 0, y: 0)
                .frame(width: 70, height: 70, alignment: .center)
            Image(systemName: text)
                .font(.system(size: 40))
                .foregroundColor(isGrayedOut ? .gray : .black)
        }
        .opacity(isGrayedOut ? 0.7 : 1.0)
    }
        
}

struct upToButton_Previews: PreviewProvider {
    static var previews: some View {
        UpToButton(text: "plus", isGrayedOut: .constant(false))
    }
}
