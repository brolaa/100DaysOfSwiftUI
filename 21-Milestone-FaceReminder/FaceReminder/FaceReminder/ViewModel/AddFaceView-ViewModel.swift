//
//  AddFaceView-ViewModel.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 24/07/2023.
//

import Foundation
import SwiftUI

extension AddFaceView {
    @MainActor class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var showingImagePicker = false
        @Published var inputImage: UIImage?
        @Published var image: Image?
        
        @Binding var faces: [Face]
        
        let locationFetcher = LocationFetcher()
        
        init(faces: Binding<[Face]>) {
            self._faces = faces
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            
            image = Image(uiImage: inputImage)
        }
        
        func validateData() -> Bool {
            if inputImage == nil || name.isEmpty {
                return true
            }
            
            return false
        }
        
        
        func saveFace() {
            var latitude: Double? = nil
            var longtiude: Double? = nil
            
            if let location = self.locationFetcher.lastKnownLocation {
                latitude = location.latitude
                longtiude = location.longitude
            }
            
            let face = Face(id: UUID(), name: self.name, latitude: latitude, longitude: longtiude)
            
            faces.append(face)
            faces.sort()
            DataMangement.encodeFaces(pathName: "Faces", faces: faces)
            
            if let inputImage = inputImage {
                DataMangement.saveImage(pathName: face.id.uuidString, image: inputImage)
            }
        }
    }
}
