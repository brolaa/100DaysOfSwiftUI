//
//  FriendDetail.swift
//  FriendFace
//
//  Created by Bartosz Rola on 12/03/2023.
//

import SwiftUI

struct FriendDetail: View {
    let user: User
    let friends: [User]
    let users: [User]
    
    var body: some View {
        List {
            Text(user.isActive ? "Active" : "Inactive")
                .foregroundColor(user.isActive ? .green : .gray)
                .font(.headline)
            
            Section ("Personal Information"){
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("E-mail: \(user.email)")
                Text("Address: \(user.address)")
            }
            
            Section ("About") {
                Text(user.about)
            }
            
            Section ("Registered") {
                Text(user.formattedDate)
            }
            
            Section ("Tags") {
                ForEach(user.tags, id: \.self) {
                    Text($0)
                }
            }
            
            Section ("Friends") {
                ForEach(friends) { friend in
                    NavigationLink {
                        FriendDetail(users: users, user: friend)
                    } label: {
                        Text(friend.name)
                    }
                }
            }
            
        }
        .navigationTitle(user.name)
    }
    
    init(users: [User], user: User) {
        self.user = user
        self.users = users
        self.friends = user.friends.map { friend in
            if let found = users.first(where: { $0.id==friend.id }) {
                return found
            } else {
                fatalError("Missing \(friend.name)")
            }
        }
    }
}

struct FriendDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        FriendDetail(users: [User](),user: User(id: UUID(), isActive: true, name: "John Smith", age: 25, company: "company", email: "email@example.com", address: "31 Long Street, Washington", about: "Lorem ipsum et dolor se", registered: Date(), tags: ["tag"], friends: []))
    }
}
