//
//  SortMenuView.swift
//  SnowSeeker
//
//  Created by Bartosz Rola on 30/08/2023.
//

import SwiftUI

struct SortMenuView: View {
    @Binding var sortOrder: SortOrder
    
    var body: some View {
        Menu("Sort") {
            ForEach(SortOrder.allCases, id: \.rawValue) { type in
                Button {
                    sortOrder = type
                } label: {
                    HStack {
                        Text(type.rawValue)
                    }
                    
                    if sortOrder == type {
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .accessibilityLabel("Checked")
                    }
                }
            }
        }
    }
}

struct SortMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortMenuView(sortOrder: .constant(.standard))
    }
}
