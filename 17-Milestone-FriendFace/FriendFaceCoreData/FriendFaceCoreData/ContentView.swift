//
//  ContentView.swift
//  FriendFaceCoreData
//
//  Created by Bartosz Rola on 31/03/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor<CachedUser>(\.name)]) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink(destination: {
                    UserDetail(user: user)
                }, label: {
                    HStack {
                        ActivityIndicator(isActive: user.isActive)
                        
                        Text(user.wrappedName)
                    }
                })
            }
            
            .navigationTitle("FriendFace")
            .task {
                await loadUsers()
            }
        }
    }
    
    func loadUsers() async {
        if (!cachedUsers.isEmpty) {
            print("Data is here!")
            return
        }
        
        print("Downloading data!")
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode([User].self, from:  data)
                
                let users = decodedData
                
                //save users
                await MainActor.run {
                    print("Saving data!")
                    saveUsers(users: users)
                }
            
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func saveUsers(users: [User]) {
        for user in users {
            let newUser = CachedUser(context: moc)
            newUser.id = user.id
            newUser.isActive = user.isActive
            newUser.name = user.name
            newUser.age = Int16(user.age)
            newUser.company = user.company
            newUser.email = user.email
            newUser.address = user.address
            newUser.about = user.about
            newUser.registered = user.registered
            newUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                newFriend.addToOrigin(newUser)
                newUser.addToFriend(newFriend)
            }
            
            try? moc.save()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static let dataController = DataController()
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
