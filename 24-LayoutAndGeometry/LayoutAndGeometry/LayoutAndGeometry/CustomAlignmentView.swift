//
//  CustomAlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Bartosz Rola on 14/08/2023.
//

import SwiftUI

extension VerticalAlignment {
    // why enum not struct - to not create useless instances
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@pies")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("pies")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PIES")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }

                    .font(.largeTitle)
            }
        }
        .navigationTitle("Custom alignment guide")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentView()
    }
}
