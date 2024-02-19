//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 31/07/2023.
//

import SwiftUI

struct ContentView: View {
    let views: [(label: String, view: AnyView)] = [
        ("Alignment and alignment guides", AnyView(TextAndAlignmentView())),
        ("Custom alignment guide", AnyView(CustomAlignmentView())),
        ("Absolute positioning", AnyView(AbsolutePositioningView())),
        ("GeometryReader", AnyView(GeometryReaderView())),
        ("Challenge", AnyView(ChallengeView()))
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(views.indices) { ind in
                    NavigationLink {
                        views[ind].view
                    } label: {
                        Text(views[ind].label)
                    }
                }
            }
            .navigationTitle("Layout and Geometry")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



