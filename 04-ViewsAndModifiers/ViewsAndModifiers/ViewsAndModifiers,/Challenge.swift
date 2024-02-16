//
//  Challenge.swift
//  ViewsAndModifiers,
//
//  Created by Bartosz Rola on 30/09/2022.
//

import SwiftUI

struct Challenge: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .bigTitle()
    }
}

struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

extension View {
    func bigTitle() -> some View {
        modifier(LargeBlue())
    }
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}
