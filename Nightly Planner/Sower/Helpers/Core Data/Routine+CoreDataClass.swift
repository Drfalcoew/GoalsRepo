//
//  Routine+CoreDataClass.swift
//  Sower
//
//  Created by Drew Foster on 3/28/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


public class Routine: NSManagedObject {

}


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var goal: UUID?
    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var routine_Goal: Goal?

}
