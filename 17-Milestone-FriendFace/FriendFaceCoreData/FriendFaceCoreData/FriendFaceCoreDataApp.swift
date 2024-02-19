//
//  FriendFaceCoreDataApp.swift
//  FriendFaceCoreData
//
//  Created by Bartosz Rola on 31/03/2023.
//

import SwiftUI

@main
struct FriendFaceCoreDataApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
