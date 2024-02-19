//
//  ContentView.swift
//  FriendFace
//
//  Created by Bartosz Rola on 08/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: {
                    FriendDetail(users: users ,user: user)
                }, label: {
                    HStack {
                        ActivityIndicator(isActive: user.isActive)
                        
                        Text(user.name)
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
        if (!users.isEmpty) {
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
                
                users = decodedData
                
            } catch {
                print(error.localizedDescription)
            }
             
        } catch {
            print("Invalid data")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
