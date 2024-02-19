//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Bartosz Rola on 27/07/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
