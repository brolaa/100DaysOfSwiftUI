//
//  ContentView.swift
//  HotProspects
//
//  Created by Bartosz Rola on 25/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var prospects = Prospects()
    @State var sortBy: SortType = .recent
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none, sortBy: $sortBy)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted, sortBy: $sortBy)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted, sortBy: $sortBy)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}