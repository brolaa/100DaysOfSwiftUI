//
//  ArrowView.swift
//  Drawing
//
//  Created by Bartosz Rola on 21/02/2023.
//

import SwiftUI

struct ArrowView: View {
    @State private var insetAmount = 20.0
    
    var body: some View {
        VStack {
            Arrow()
                .strokeBorder(.blue, lineWidth: insetAmount)
                .frame(width: 250, height: 400)
                .onTapGesture {
                    withAnimation {
                        insetAmount = Double.random(in: 10...50)
                    }
            }
            .padding()
            .navigationTitle("Arrow")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
