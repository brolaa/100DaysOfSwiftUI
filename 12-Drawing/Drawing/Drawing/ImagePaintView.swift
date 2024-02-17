//
//  ImagePaintView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct ImagePaintView: View {
    var body: some View {
        VStack {
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
        }
        .padding()
        .navigationTitle("Image paint")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImagePaintView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintView()
    }
}
