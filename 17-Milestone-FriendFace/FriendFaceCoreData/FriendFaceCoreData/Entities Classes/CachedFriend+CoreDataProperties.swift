//
//  CachedFriend+CoreDataProperties.swift
//  FriendFaceCoreData
//
//  Created by Bartosz Rola on 31/03/2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var origin: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }

}

// MARK: Generated accessors for origin
extension CachedFriend {

    @objc(addOriginObject:)
    @NSManaged public func addToOrigin(_ value: CachedUser)

    @objc(removeOriginObject:)
    @NSManaged public func removeFromOrigin(_ value: CachedUser)

    @objc(addOrigin:)
    @NSManaged public func addToOrigin(_ values: NSSet)

    @objc(removeOrigin:)
    @NSManaged public func removeFromOrigin(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}
