//
//  User.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/12/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//


import Foundation


struct User {
    
    let uid: String?
    let email: String?
    let userName: String?
    let rep: Double?
    
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
        userName = authData.userName!
        rep = authData.rep!
    }
    
    /*
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        userName = snapshotValue["userName"] as? String
        rep = snapshotValue["rep"] as? Double
        uid = snapshotValue["uid"] as? String
        email = snapshotValue["email"] as? String
    }*/
    
    
    
    
    
    init(uid: String, email: String, userName: String, rep: Double) {
        self.uid = uid
        self.email = email
        self.userName = userName
        self.rep = rep
    }
    
}
