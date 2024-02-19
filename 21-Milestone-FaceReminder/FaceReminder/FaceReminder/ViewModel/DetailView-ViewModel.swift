//
//  DetailView-ViewModel.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 24/07/2023.
//

import Foundation
import MapKit
import SwiftUI

extension DetailView {
    @MainActor class ViewModel: ObservableObject {
        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        
        let face: Face
        let image: Image?
        
        init(face: Face) {
            self.face = face
            
            if let image = DataMangement.loadImage(pathName: face.id.uuidString) {
                self.image = image
            } else {
                image = nil
            }
            
            if face.coordinate != nil {
                self._region = Published(wrappedValue: MKCoordinateRegion(center: face.coordinate!, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
            }
        }
    }
}
