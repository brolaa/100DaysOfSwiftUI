//
//  AnimatingGestures.swift
//  Animations
//
//  Created by Bartosz Rola on 02/10/2022.
//

import SwiftUI

struct AnimatingGestures: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )
            //.animation(.spring(), value: dragAmount)
        
    }
}

struct AnimatingGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGestures()
    }
}
