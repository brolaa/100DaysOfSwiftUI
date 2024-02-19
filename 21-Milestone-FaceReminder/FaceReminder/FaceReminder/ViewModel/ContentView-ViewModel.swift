//
//  ContentView-ViewModel.swift
//  FaceReminder
//
//  Created by Bartosz Rola on 24/07/2023.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingAddFace = false
        @Published  var faces: [Face]
        
        init() {
            faces = DataMangement.decodeFaces(pathName: "Faces").sorted()
        }
        
        func deleteFace(at offsets: IndexSet) {
            for offset in offsets {
                DataMangement.removeImage(pathName: faces[offset].id.uuidString)
                faces.remove(at: offset)
                DataMangement.encodeFaces(pathName: "Faces", faces: faces)
            }
        }
    }
}
