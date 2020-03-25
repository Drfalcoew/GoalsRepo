//
//  LongTermGoalAttributes.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/7/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit


struct LongTermGoalAttributes {
    
    let targetDate: Date?
    let name: String?
    let completedTasks: CGFloat? // eg: 16
    let totalTasks: CGFloat? // eg: 20  // 16/20 = 4/5 = 80% completion
    let icon: Int? // image = "tree_(\icon)"
    let createdDate : Date?
    
    
    //let ref: FIRDatabaseReference?
    
    
    init(name: String, targetDate: Date?, completedTasks: CGFloat, icon: Int, totalTasks: CGFloat, createdDate : Date?) {
        self.name = name
        self.totalTasks = totalTasks
        self.targetDate = targetDate
        self.icon = icon
        self.completedTasks = completedTasks
        self.createdDate = createdDate
    }
    
    
    
   /* init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        name = snapshotValue["goalName"] as? String
        reason = snapshotValue["reason"] as? String
        date = snapshotValue["targetDate"] as? String
        icon = snapshotValue["icon"] as? Int
        completed = snapshotValue["completed"] as? CGFloat
        shortTerm = snapshotValue["shortTerm"] as? CGFloat
        //ref = snapshot.ref
    }*/
    
    func toAnyObject() -> Any {
        return [
            "name": name as Any,
            "icon": icon as Any,
            "targetDate": targetDate as Any,
            "completedTasks": completedTasks as Any,
            "createdDate": createdDate as Any,
            "totalTasks" : totalTasks as Any
        ]
    }
}
