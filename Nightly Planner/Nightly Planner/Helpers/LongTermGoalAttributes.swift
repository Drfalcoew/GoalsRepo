//
//  LongTermGoalAttributes.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/7/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


struct LongTermGoalAttributes {
    
    let date: String?
    let name: String?
    let completed: CGFloat?
    let shortTerm: CGFloat?
    let icon: Int?
    let reason : String?
    
    
    //let ref: FIRDatabaseReference?
    
    
    init(name: String, reason: String, date: String, completed: CGFloat, icon: Int, shortTerm: CGFloat) {
        self.name = name
        self.shortTerm = shortTerm
        self.reason = reason
        self.date = date
        self.icon = icon
        self.completed = completed
    }
    
    
    
    init(snapshot: QueryDocumentSnapshot) {
        let snapshotValue = snapshot.data() as [String: AnyObject]
        name = snapshotValue["goalName"] as? String
        reason = snapshotValue["reason"] as? String
        date = snapshotValue["targetDate"] as? String
        icon = snapshotValue["icon"] as? Int
        completed = snapshotValue["completed"] as? CGFloat
        shortTerm = snapshotValue["shortTerm"] as? CGFloat
        //ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "goalName": name as Any,
            "reason": reason as Any,
            "icon": icon as Any,
            "date": date as Any,
            "completed": completed as Any,
            "shortTerm": shortTerm as Any
        ]
    }
}
