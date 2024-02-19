//
//  DynamicFilteringView.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 01/03/2023.
//

import CoreData
import SwiftUI

struct DynamicFilteringView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    @State private var filterType = FilterType.beginsWith
    
    let sortDescriptors = [SortDescriptor<Singer>(\.lastName),
        SortDescriptor<Singer>(\.firstName)]
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, filterType: filterType, sortDescriptors: sortDescriptors) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            //FilteredList(filter: lastNameFilter)
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
            
            Picker("Filter type", selection: $filterType) {
                ForEach(FilterType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
        .navigationTitle("Dynamic filtering")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DynamicFilteringView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicFilteringView()
    }
}
