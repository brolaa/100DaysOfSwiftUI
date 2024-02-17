//
//  ArcView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct ArcView: View {
    var body: some View {
        VStack {
            Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(.blue, lineWidth: 40)
        }
        .padding()
        .navigationTitle("Arc")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView()
    }
}
