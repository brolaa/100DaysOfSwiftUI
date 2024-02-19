//
//  TextAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct TextAlignmentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Alignment: .bottom:")
                    .font(.headline)
                
                HStack(alignment: .bottom) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }
            }
            .padding()
            
            // align text on the baseline of the last child
            VStack {
                Text("Alignment: .lastTextBaseline:")
                    .font(.headline)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }
            }
            .padding()
        }
        .navigationTitle("Text alignment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TextAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        TextAlignmentView()
    }
}
