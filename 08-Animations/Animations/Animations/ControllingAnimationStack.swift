//
//  ControllingAnimationStack.swift
//  Animations
//
//  Created by Bartosz Rola on 02/10/2022.
//

import SwiftUI

struct ControllingAnimationStack: View {
    @State private var enabled = false
    
    var body: some View {
    
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(.default, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}

struct ControllingAnimationStack_Previews: PreviewProvider {
    static var previews: some View {
        ControllingAnimationStack()
    }
}
