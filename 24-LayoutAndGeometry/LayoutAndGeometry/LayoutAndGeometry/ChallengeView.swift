//
//  ChallengeView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct ChallengeView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            //.background(colors[index % 7])
                            .background(Color(hue: getHue(geo), saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).minY / 200)
                            .scaleEffect(getScale(geo))
                    }
                    .frame(height: 40)
                }
            }
        }
        .navigationTitle("Challenge")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getScale(_ geo: GeometryProxy) -> Double {
        return max(0.5 , min(1, (1 - (1 / (sqrt(geo.frame(in: .global).minY)) * 10) + 0.35)))
        //return max(0.5 , min(1, geo.frame(in: .global).minY / 500))
    }
    
    func getHue(_ geo: GeometryProxy) -> Double {
        return max(0, min(1, 1 / sqrt(geo.frame(in: .global).minY) * 10 - 0.3))
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
