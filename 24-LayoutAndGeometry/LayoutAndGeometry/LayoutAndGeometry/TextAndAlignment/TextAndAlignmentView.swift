//
//  TextAndAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 19/08/2023.
//

import SwiftUI

struct TextAndAlignmentView: View {
    let views: [(label: String, view: AnyView)] = [
        ("Text alignment", AnyView(TextAlignmentView())),
        ("Customize alignment", AnyView(CustomizeAlignmentView())),
        ("Tiered text", AnyView(TieredTextView()))
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
        .navigationTitle("Alignment and alignment guides")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TextAndAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        TextAndAlignmentView()
    }
}
