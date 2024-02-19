//
//  AbsolutePositioningView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

/*
 offset - changing the location where a view should be rendered without actually changing its underlying geometry
 
 postion - absolutely position a SwiftUI view
 */

struct AbsolutePositioningView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello, world!")
                    .background(.red)
                    .position(x: 100, y: 100)
            }
            .frame(height: 250)
            
            Divider()
            
            VStack {
                Text("Hello, world!")
                    .position(x: 100, y: 100)
                    .background(.red)
            }
            .frame(height: 250)
            
            Divider()
            
            VStack {
                Text("Hello, world!")
                    .offset(x: 100, y: 100)
                    .background(.red)
            }
            .frame(height: 250)
            
            Divider()
            
            VStack {
                Text("Hello, world!")
                    .background(.red)
                    .offset(x: 100, y: 100)
            }
            .frame(height: 250)
            
            Divider()
        }
        .navigationTitle("Absolute positioning")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AbsolutePositioningView_Previews: PreviewProvider {
    static var previews: some View {
        AbsolutePositioningView()
    }
}
