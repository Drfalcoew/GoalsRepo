//
//  Task+CoreDataClass.swift
//  Sower
//
//  Created by Drew Foster on 3/28/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


public class Goal: NSManagedObject {

}

extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var routine: Bool
    @NSManaged public var date: Date?
    @NSManaged public var completedDate: Date?
    @NSManaged public var days: Int16
    @NSManaged public var category: Int16
    @NSManaged public var active: Bool
    @NSManaged public var name: String?

}
