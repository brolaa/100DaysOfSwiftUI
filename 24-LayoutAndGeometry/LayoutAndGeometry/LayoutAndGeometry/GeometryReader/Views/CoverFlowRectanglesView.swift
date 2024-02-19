//
//  CoverFlowRectanglesView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct CoverFlowRectanglesView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(1..<20) { num in
                    GeometryReader { geo in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                    }
                    .frame(width: 200, height: 200)
                }
            }
        }
    }
}

struct CoverFlowRectanglesView_Previews: PreviewProvider {
    static var previews: some View {
        CoverFlowRectanglesView()
    }
}
