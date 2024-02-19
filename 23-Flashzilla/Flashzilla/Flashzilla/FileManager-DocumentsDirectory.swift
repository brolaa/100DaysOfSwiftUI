//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Bartosz Rola on 30/07/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
