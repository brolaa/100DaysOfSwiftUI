//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 28/02/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
