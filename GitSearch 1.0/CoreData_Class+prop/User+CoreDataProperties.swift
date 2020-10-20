//
//  User+CoreDataProperties.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var avtarUrl: String?
    @NSManaged public var location: String?
    @NSManaged public var bio: String?

}

extension User : Identifiable {

}
