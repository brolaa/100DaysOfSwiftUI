//
//  Modifiers.swift
//  RockPaperScissors
//
//  Created by Bartosz Rola on 30/09/2022.
//

import Foundation
import SwiftUI

struct MainTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(Color.white)
            .shadow(color: Color.black, radius: 3, x: 0, y: 0)
    }
}

struct SecondaryTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(Color.white)
            .shadow(color: Color.black, radius: 3, x: 0, y: 0)
    }
}

extension View {
    func mainTitle() -> some View {
        modifier(MainTitleStyle())
    }
    
    func secondaryTitle() -> some View {
        modifier(SecondaryTitleStyle())
    }
}
