//
//  TieredTextView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct TieredTextView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
        .navigationTitle("Tiered text")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TieredTextView_Previews: PreviewProvider {
    static var previews: some View {
        TieredTextView()
    }
}
