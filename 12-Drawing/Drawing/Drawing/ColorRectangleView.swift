//
//  ColorRectangleView.swift
//  Drawing
//
//  Created by Bartosz Rola on 22/02/2023.
//

import SwiftUI

struct ColorRectangleView: View {
    @State private var colorCycle = 0.0
    
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 1.0
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 0.0
    
    var body: some View {
        ScrollView {
            ColorCyclingRectangle(amount: colorCycle, gradientStartX: gradientStartX, gradientStartY: gradientStartY, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 300)

            VStack() {
                Text("Color")
                Slider(value: $colorCycle)
                
                Text("Gradient start X")
                Slider(value: $gradientStartX)
                
                Text("Gradient start Y")
                Slider(value: $gradientStartY)
                
                Text("Gradient end X")
                Slider(value: $gradientEndX)
                
                Text("Gradient end Y")
                Slider(value: $gradientEndY)
            }
            .padding()
            .navigationTitle("Color cyling rectangle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ColorRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorRectangleView()
    }
}
