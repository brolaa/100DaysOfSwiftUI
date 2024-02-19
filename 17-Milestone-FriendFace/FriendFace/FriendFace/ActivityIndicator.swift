//
//  ActivityIndicator.swift
//  FriendFace
//
//  Created by Bartosz Rola on 12/03/2023.
//

import SwiftUI

struct ActivityIndicator: View {
    let isActive: Bool
    
    var body: some View {
        Circle()
            .fill(isActive ? .green : .gray)
            .frame(width: 15, height: 15)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isActive: true)
    }
}
