//
//  PictureBlurView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct PictureBlurView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Image("Example")
               .resizable()
               .scaledToFit()
               .frame(width: 200, height: 200)
               .saturation(amount)
               .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .navigationTitle("Picture blur")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PictureBlurView_Previews: PreviewProvider {
    static var previews: some View {
        PictureBlurView()
    }
}
