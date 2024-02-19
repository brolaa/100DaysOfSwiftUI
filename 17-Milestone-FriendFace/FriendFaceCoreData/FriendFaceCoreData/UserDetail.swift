//
//  UserDetail.swift
//  FriendFaceCoreData
//
//  Created by Bartosz Rola on 31/03/2023.
//

import SwiftUI

struct UserDetail: View {
    let user: CachedUser
    @FetchRequest var fetchedFriends: FetchedResults<CachedUser>
    
    var body: some View {
        List {
            Text(user.isActive ? "Active" : "Inactive")
                .foregroundColor(user.isActive ? .green : .gray)
                .font(.headline)
            
            Section ("Personal Information"){
                Text("Age: \(user.age)")
                Text("Company: \(user.wrappedCompany)")
                Text("E-mail: \(user.wrappedEmail)")
                Text("Address: \(user.wrappedAddress)")
            }
            
            Section ("About") {
                Text(user.wrappedAbout)
            }
            
            Section ("Registered") {
                Text(user.formattedDate)
            }
            
            Section ("Tags") {
                ForEach(user.wrappedTags, id: \.self) {
                    Text($0)
                }
            }
            
            Section ("Friends") {
                ForEach(fetchedFriends) { friend in
                    NavigationLink {
                        UserDetail(user: friend)
                    } label: {
                        Text(friend.wrappedName)
                    }
                }
            }
            
            //Friends section without navigation link to friends profiles
            /*
             Section ("Friends") {
                 ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                 }
             }
             */
            
            /*
            Section ("Friends") {
                ForEach(user.friendsArray) { friend in
                    NavigationLink {
                        UserDetail(user: findFriendById(id: friend.wrappedId))
                    } label: {
                        Text(friend.wrappedName)
                    }
                }
            }
             */
        }
        .navigationTitle(user.wrappedName)
    }
    
    init(user: CachedUser) {
        self.user = user
        var uuids = [UUID]()
        for friend in user.friendsArray {
            uuids.append(friend.wrappedId)
        }
    
        //fetch CachedUsers by user's friends id list
        _fetchedFriends = FetchRequest(sortDescriptors: [SortDescriptor<CachedUser>(\.name)], predicate:
                        NSPredicate(format: "id IN %@", uuids))
        
    }
    
    
    func findFriendById(id: UUID) -> CachedUser {
        guard let friend = fetchedFriends.first(where: {
            $0.wrappedId == id
        }) else {
            fatalError("Missing \(id)")
        }
        return friend
    }
}

/*
struct UserDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        UserDetail(users: [User](),user: User(id: UUID(), isActive: true, name: "John Smith", age: 25, company: "company", email: "email@example.com", address: "31 Long Street, Washington", about: "Lorem ipsum et dolor se", registered: Date(), tags: ["tag"], friends: []))
    }
}
*/
