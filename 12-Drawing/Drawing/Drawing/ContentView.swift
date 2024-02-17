//
//  ContentView.swift
//  Drawing
//
//  Created by Bartosz Rola on 20/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    let views: [AnyView] = [
        AnyView(AnimatingShapes()),
        AnyView(AnimatingComplexShapes()),
        AnyView(RGBCirclesView()),
        AnyView(PictureBlurView()),
        AnyView(ColorCircleView()),
        AnyView(ColorRectangleView()),
        AnyView(ArrowView()),
        AnyView(ImagePaintView()),
        AnyView(ArcView()),
        AnyView(TriangleView()),
        AnyView(FlowerView())
    ]
    
    let labels = [
        "Animating shapes",
        "Animating complex shapes",
        "RGB circles",
        "Picture blur",
        "Color cycling circle",
        "Color cycling rectangle",
        "Arrow",
        "Image paint",
        "Arc",
        "Triangle",
        "Flower"
    ]
    
    @State private var selectedView = ArcView()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(views.indices) { ind in
                    NavigationLink {
                        views[ind]
                    } label: {
                        Text(labels[ind])
                    }
                }
                 
            }
            .navigationTitle("Drawing")
            .preferredColorScheme(.dark)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

/* blur
 Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: 200, height: 200)
    .saturation(amount)
    .blur(radius: (1 - amount) * 20)
 */
