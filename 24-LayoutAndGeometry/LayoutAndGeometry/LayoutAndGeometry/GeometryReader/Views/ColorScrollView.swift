//
//  ColorScrollView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct ColorScrollView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                GeometryReader { geo in
                    Text("Row #\(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(colors[index % 7])
                        .rotation3DEffect(.degrees(geo.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))

                }
                .frame(height: 40)
            }
        }
    }
}

struct ColorScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ColorScrollView()
    }
}
