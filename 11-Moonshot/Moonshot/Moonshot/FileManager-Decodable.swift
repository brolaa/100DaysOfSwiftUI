//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Bartosz Rola on 01/05/2023.
//

import Foundation

extension FileManager {
    static func decode<T: Codable>(_ file: String) -> T {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = paths[0].appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from documents.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        print("Data loaded successfully!")
        return loaded
    }
}
