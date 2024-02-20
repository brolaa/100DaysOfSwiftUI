//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Bartosz Rola on 29/08/2023.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        // load saved our data
        if let data = UserDefaults.standard.stringArray(forKey: saveKey) {
            // convert to string set and assign
            resorts = Set(data)
            return
        }
        // still here? Use an empty array
        resorts = []
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write our data
        
        // convert to array
        let favouritesArray = Array(resorts)
        // write to UserDefaults
        UserDefaults.standard.set(favouritesArray, forKey: saveKey)
    }
}
