//
//  ContentView.swift
//  Moonshot
//
//  Created by Bartosz Rola on 17/02/2023.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    showingGrid ? Text("List") : Text("Grid")
                }
                .accessibilityHint(showingGrid ? "Switches to list view" : "Switches to grid view")
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
