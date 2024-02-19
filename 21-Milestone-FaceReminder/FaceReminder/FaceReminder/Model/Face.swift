//
//  Face.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 21/07/2023.
//

import Foundation
import CoreLocation

struct Face: Identifiable, Codable, Comparable {
    let id: UUID
    var name: String
    
    let latitude: Double?
    let longitude: Double?
        
    var coordinate: CLLocationCoordinate2D? {
        if let latitude = latitude, let longitude = longitude {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
    
    static let example = Face(id: UUID(), name: "Johnny Test", latitude: 52.23194, longitude: 21.00667)
    
    static func < (lhs: Face, rhs: Face) -> Bool {
        lhs.name < rhs.name
    }
}
