//
//  FileManager-DataManagement.swift
//  Flashzilla
//
//  Created by Bartosz Rola on 30/07/2023.
//

import Foundation

extension FileManager {
    static func loadData<T: Codable>(savePath: URL) -> [T] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([T].self, from: data) {
                return decoded
            }
        }
        
        return [T]()
    }
    
    static func saveData<T: Codable>(savePath: URL, data: [T]) {
        if let encoded = try? JSONEncoder().encode(data) {
            try? encoded.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        }
    }
}

