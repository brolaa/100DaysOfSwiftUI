//
//  ContentView.swift
//  ViewsAndModifiers,
//
//  Created by Bartosz Rola on 29/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Challenge()
    }
}

// custom modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// custom extension to omit using modifier()
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 VStack {
     Text("Hello, world!")
         .titleStyle()
     Color.blue
         .frame(width: 300, height: 200)
         .watermarked(with: "Hacking with Swift")
 }
 */
