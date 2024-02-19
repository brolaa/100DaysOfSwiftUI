//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Bartosz Rola on 28/02/2023.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, filterType: FilterType, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        //change the whole fetch request itself
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(filterType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

/*
 struct FilteredList: View {
     @FetchRequest var fetchRequest: FetchedResults<Singer>
     
     var body: some View {
         List(fetchRequest, id: \.self) { singer in
             Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
         }
     }
     
     init(filter: String) {
         //change the whole fetch request itself
         _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
     }
 }
 */

/*
struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
*/
