//
//  CustomizeAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

struct CustomizeAlignmentView: View {
    @State private var alignment = HorizontalAlignment.leading
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Hello, world!")
                    .alignmentGuide(.leading) { d in d[alignment] }
                Text("This is a longer line of text")
            }
            .background(.red)
            .frame(width: 400, height: 400)
            .background(.blue)
            
            HStack {
                Button {
                    alignment = .leading
                } label: {
                    Text("leading")
                        .padding()
                        .background(alignment == .leading ? .teal : .blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }
                
                Button {
                    alignment = .trailing
                } label: {
                    Text("trailing")
                        .padding()
                        .background(alignment == .trailing ? .teal : .blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                }

            }

        }
        .navigationTitle("Customize alignment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomizeAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeAlignmentView()
    }
}
