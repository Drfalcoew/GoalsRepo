//
//  TabViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/10/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vcOne = CreateShortTerm()
        
        vcOne.tabBarItem = UITabBarItem(title: "Short Term", image: UIImage(named: "icon_8"), tag: 0)
        
        let vcTwo = CreateLongTerm()
        
        vcTwo.tabBarItem = UITabBarItem(title: "Long Term", image: UIImage(named: "icon_17"), tag: 1)
        
        let tabBarList = [vcOne, vcTwo]
        
        viewControllers = tabBarList
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
