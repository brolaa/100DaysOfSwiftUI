//
//  Grouping.swift
//  Accessibility_Project
//
//  Created by Bartosz Rola on 11/05/2023.
//

import SwiftUI

struct Grouping: View {
    var body: some View {
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        //.accessibilityElement(children: .combine)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Your score is 1000")
        
        //Image(decorative: "lukas-mann")
        //    .resizable()
        //    .scaledToFit()
        //    .accessibilityHidden(true)
    }
}

struct Grouping_Previews: PreviewProvider {
    static var previews: some View {
        Grouping()
    }
}
