//
//  DataMangement.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 22/07/2023.
//

import Foundation
import SwiftUI

class DataMangement {
    static func decodeFaces(pathName: String) -> [Face] {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: savePath)
            let faces = try JSONDecoder().decode([Face].self, from: data)
            print("Data loaded sucessfully!")
            return faces
        } catch {
            print("Unable to load saved data")
        }
        return []
    }
    
    static func encodeFaces(pathName: String, faces: [Face]) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(pathName)
        
        do {
            let data = try JSONEncoder().encode(faces)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    static func saveImage(pathName: String, image: UIImage) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(pathName)
        
        do {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
        } catch {
            print("Unable to save image.")
        }
    }
    
    static func loadImage(pathName: String) -> Image? {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: savePath)
            let image = UIImage(data: data)
            if let image = image {
                return Image(uiImage: image)
            }
        } catch {
            print("Unable to load saved image")
        }
        return nil
    }
    
    static func removeImage(pathName: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(pathName)

        do {
            try FileManager.default.removeItem(at: savePath)
            print("Image removed successfully!")
        } catch {
            print("Unable to delete picture")
        }
    }
}
