//
//  User+CoreDataProperties.swift
//  
//
//  Created by  Alex Kolovatov on 15/11/2018.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var password: String?

}
