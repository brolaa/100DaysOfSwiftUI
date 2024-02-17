//
//  RBGCirclesView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct RGBCirclesView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .navigationTitle("Rgb circles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RBGCirclesView_Previews: PreviewProvider {
    static var previews: some View {
        RGBCirclesView()
    }
}

/*
 ZStack {
     Image("Example")

     Rectangle()
         .fill(.red)
         .blendMode(.multiply)
 }
 .frame(width: 400, height: 500)
 .clipped()
 */


/*
 Image("Example")
     .resizable()
     .scaledToFit()
     .colorMultiply(.red)
 */
