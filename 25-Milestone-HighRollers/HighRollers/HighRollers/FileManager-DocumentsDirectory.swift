//
//  FileManager-DocumentsDirectory.swift
//  HighRollers
//
//  Created by Bartosz Rola on 22/08/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
