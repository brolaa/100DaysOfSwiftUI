//
//  GeometryReaderView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 19/08/2023.
//

import SwiftUI

struct GeometryReaderView: View {
    let views: [(label: String, view: AnyView)] = [
        ("Introduction", AnyView(GeometryReaderIntroduction())),
        ("Coordinate spaces", AnyView(CoordinateSpacesView())),
        ("Helix-style spinning effect scroling rectangles", AnyView(ColorScrollView())),
        ("Helix-style spinning effect scroling rectangles - fixed", AnyView(RotatingColorScrollView())),
        ("CoverFlow-style scrolling rectangles", AnyView(CoverFlowRectanglesView()))
    ]
    
    var body: some View {
        List {
            ForEach(views.indices) { ind in
                NavigationLink {
                    views[ind].view
                } label: {
                    Text(views[ind].label)
                }
            }
        }
        .navigationTitle("GeometryReader")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
