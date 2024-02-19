//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 28/02/2023.
//
import CoreData
import SwiftUI

struct ContentView: View {
    let views: [(label: String, view: AnyView)] = [
        ("Relationships", AnyView(RelationshipsView())),
        ("Dynamic filtering", AnyView(DynamicFilteringView())),
        ("Filtering", AnyView(FilteringView())),
        ("Unique elements", AnyView(UniqueElementsView()))
    ]
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(views.indices) { ind in
                    NavigationLink {
                        views[ind].view
                    } label: {
                        Text(views[ind].label)
                    }
                }
            }
            .navigationTitle("CoreData Project")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* wrap moc with .hasChanges to check if there are changes
 Button("Save") {
     if moc.hasChanges {
         try? moc.save()
     }
 }
 */
