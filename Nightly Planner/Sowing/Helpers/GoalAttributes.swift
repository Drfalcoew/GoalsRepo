//
//  GoalAttributes.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/10/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit


struct GoalAttributes {
    
    let date: String
    let completedDate : String
    let name: String
    var completed: Bool
    var consistency: Int?
    var category : Int?
    var routine : Bool?
    var active: Bool?
    //let ref: FIRDatabaseReference?
    
    
    init(name: String, date: String, completedDate : String, completed: Bool, consistency: Int, category: Int?, routine: Bool, active: Bool) {
        self.name = name
        self.consistency = consistency
        self.date = date
        self.category = category
        self.completed = completed
        self.routine = routine
        self.active = active
        self.completedDate = completedDate
    }
   /*
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        name = snapshotValue["goalName"] as? String
        date = snapshotValue["date"] as? String
        completed = snapshotValue["completed"] as? Bool
        ref = snapshotValue["ref"] as? String
        daysTaken = snapshotValue["daysTaken"] as? Int
        icon = snapshotValue["icon"] as? Int
        //ref = snapshot.ref
    }*/
    
    func toAnyObject() -> Any {
        return [
            "goalName": name as Any,
            "date": date as Any,
            "consistency": consistency as Any,
            "completed": completed as Any,
            "routine" : routine as Any,
            "completedDate": completedDate as Any
        ]
    }
}
