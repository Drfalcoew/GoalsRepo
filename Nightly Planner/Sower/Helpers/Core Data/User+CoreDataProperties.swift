//
//  User+CoreDataProperties.swift
//  Sower
//
//  Created by Drew Foster on 3/28/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var completedTasks: Int16
    @NSManaged public var incompleteTasks: Int16
    @NSManaged public var language: Int16
    @NSManaged public var name: String?

}
