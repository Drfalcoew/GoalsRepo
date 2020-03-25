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
    let name: String
    var completed: Bool
    var daysTaken: Int?
    var category : String?
    
    //let ref: FIRDatabaseReference?
    
    
    init(name: String, date: String, completed: Bool, daysTaken: Int, category: String?) {
        self.name = name
        self.daysTaken = daysTaken
        self.date = date
        self.category = category
        self.completed = completed
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
            "daysTaken": daysTaken as Any,
            "completed": completed as Any
        ]
    }
}
