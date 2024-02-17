//
//  TriangleView.swift
//  Drawing
//
//  Created by Bartosz Rola on 22/02/2023.
//

import SwiftUI

struct TriangleView: View {
    var body: some View {
        VStack {
            Triangle()
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
        }
        .navigationTitle("Triangle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TriangleView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView()
    }
}
