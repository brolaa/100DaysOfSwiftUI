//
//  Prospect.swift
//  HotProspects
//
//  Created by Bartosz Rola on 26/07/2023.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            // no saved data!
            people = []
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func remove(_ prospect: Prospect) {
        if let index = people.firstIndex(where: { $0.id == prospect.id }) {
            people.remove(at: index)
        }
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}

// for User Defaults

// 1. save key
//let saveKey = "SavedData"

// 2. loading data
//init() {
//    if let data = UserDefaults.standard.data(forKey: saveKey) {
//        if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//            people = decoded
//            return
//        }
//    }
    
    // no saved data!
//    people = []
//}

// 3. saving data

//private func save() {
//    if let encoded = try? JSONEncoder().encode(people) {
//        UserDefaults.standard.set(encoded, forKey: saveKey)
//    }
//}

