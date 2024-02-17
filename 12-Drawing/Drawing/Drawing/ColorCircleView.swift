//
//  ColorCircleView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct ColorCircleView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
        .padding()
        .navigationTitle("Color cycling circle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ColorCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCircleView()
    }
}
