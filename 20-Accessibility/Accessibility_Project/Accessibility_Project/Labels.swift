//
//  Labels.swift
//  Accessibility_Project
//
//  Created by Bartosz Rola on 11/05/2023.
//

import SwiftUI

struct Labels: View {
    let pictures = [
            "chris-turgeon",
            "harrison-steen",
            "lukas-mann",
            "real-jansen"
    ]
    
    let labels = [
        "Forest",
        "Desert",
        "House in the mountains",
        "Waterfall",
    ]

    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
    }
}

struct Labels_Previews: PreviewProvider {
    static var previews: some View {
        Labels()
    }
}
