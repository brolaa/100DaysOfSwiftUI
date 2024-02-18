//
//  Extensions.swift
//  Bookworm
//
//  Created by Bartosz Rola on 28/02/2023.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
