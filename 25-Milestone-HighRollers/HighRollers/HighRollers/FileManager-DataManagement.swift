//
//  FileManager-DataManagement.swift
//  HighRollers
//
//  Created by Bartosz Rola on 22/08/2023.
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
