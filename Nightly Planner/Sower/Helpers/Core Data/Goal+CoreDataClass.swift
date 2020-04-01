//
//  Goal+CoreDataClass.swift
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

    @NSManaged public var complete: Bool
    @NSManaged public var completedTasks: Int16
    @NSManaged public var creation: Date?
    @NSManaged public var icon: Int16
    @NSManaged public var name: String?
    @NSManaged public var target: Date?
    @NSManaged public var tasks: Int16
    @NSManaged public var level: Int16
    @NSManaged public var goal_Task: NSSet
    @NSManaged public var goal_Routine: Routine?
    @NSManaged public var id: UUID?

}

// MARK: Generated accessors for goal_Task
extension Goal {

    @objc(addGoal_TaskObject:)
    @NSManaged public func addToGoal_Task(_ value: Task)

    @objc(removeGoal_TaskObject:)
    @NSManaged public func removeFromGoal_Task(_ value: Task)

    @objc(addGoal_Task:)
    @NSManaged public func addToGoal_Task(_ values: NSSet)

    @objc(removeGoal_Task:)
    @NSManaged public func removeFromGoal_Task(_ values: NSSet)

}
