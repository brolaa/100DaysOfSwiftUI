//
//  UniqueElementsView.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 28/02/2023.
//

import SwiftUI

struct UniqueElementsView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .navigationTitle("Unique elements")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UniqueElementsView_Previews: PreviewProvider {
    static var previews: some View {
        UniqueElementsView()
    }
}
