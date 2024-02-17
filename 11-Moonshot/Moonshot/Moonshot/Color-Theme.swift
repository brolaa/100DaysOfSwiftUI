//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Bartosz Rola on 18/02/2023.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color { // extend ShapeStyle only if we are extending Colors
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
