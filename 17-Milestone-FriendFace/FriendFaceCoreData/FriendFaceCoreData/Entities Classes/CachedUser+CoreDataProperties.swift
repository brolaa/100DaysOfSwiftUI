//
//  CachedUser+CoreDataProperties.swift
//  FriendFaceCoreData
//
//  Created by Bartosz Rola on 31/03/2023.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friend: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedAbout: String {
        about ?? "No description"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    public var friendsArray: [CachedFriend] {
        //trying convert NSSet to set of CachedFriend
        let set = friend as? Set<CachedFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var wrappedTags: [String] {
        let tags = tags ?? "No Tags"
        return tags.components(separatedBy: ",")
    }
    
    var formattedDate: String {
        let date = registered ?? Date()
        return date.formatted(date: .long, time: .omitted)
    }
}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
