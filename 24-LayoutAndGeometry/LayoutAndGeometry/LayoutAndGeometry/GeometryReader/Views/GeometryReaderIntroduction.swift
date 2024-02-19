//
//  GeometryReaderIntroduction.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

/*
 geo - GeometryProxy - it contains parent's proposed size - how much space we can have plus any safe area insets we want to read and method for reading frame values
 */

struct GeometryReaderIntroduction: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }

            Text("More text")
                .background(.blue)
        }
    }
}

struct GeometryReaderIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderIntroduction()
    }
}
