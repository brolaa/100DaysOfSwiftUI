//
//  Transitions.swift
//  Animations
//
//  Created by Bartosz Rola on 02/10/2022.
//

import SwiftUI

struct Transitions: View {
    @State private var isShowingRed = false
    
    var body: some View {
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        isShowingRed.toggle()
                    }

                }

                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        //.transition(.scale)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        }
}

struct Transitions_Previews: PreviewProvider {
    static var previews: some View {
        Transitions()
    }
}
