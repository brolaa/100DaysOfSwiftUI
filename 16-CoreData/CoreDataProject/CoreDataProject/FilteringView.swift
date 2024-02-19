//
//  FilteringView.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 28/02/2023.
//

import SwiftUI

struct FilteringView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate:     NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
    //NSPredicate(format: "universe == 'Star Wars'")
    //NSPredicate(format: "name < %@", "F"))
    //NSPredicate(format: "universe == %@", "Star Wars")
    //NSPredicate(format: "name BEGINSWITH %@", "E"))
    //NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
    //[c] is case insensitive
    //NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
    // NSCompoundPredicate

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? moc.save()
            }
        }
        .navigationTitle("Filtering")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FilteringView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringView()
    }
}
