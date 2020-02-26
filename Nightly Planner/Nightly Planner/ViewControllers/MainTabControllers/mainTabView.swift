//
//  mainTabView.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/1/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class mainTabView : UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = UIColor(r: 40, g: 43, b: 53)
        self.tabBar.tintColor = UIColor(r: 40, g: 43, b: 53)
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor(r: 221, g: 221, b: 221)
        } else {
            // Fallback on earlier versions
        }
        
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.clear], for: .normal)
        
        
        _ = UINavigationController(rootViewController: ViewController())
        
        
        
        
        let home = createNavController(title: "Home", imageName: "home", vc: ViewController(), tag: 0)
        let goals = createNavController(title: "Focus", imageName: "focus", vc: FocusViewController(), tag: 1)
        let profile = createNavController(title: "Profile", imageName: "profile", vc: ProfileViewController(), tag: 2)


        let tabBarList = [home, goals, profile]
        
        viewControllers = tabBarList
    }
    
    private func createNavController(title: String, imageName: String, vc: UIViewController, tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.tag = tag
        navController.navigationBar.tintColor = UIColor(r: 221, g: 221, b: 221)
        navController.navigationBar.barTintColor = UIColor.clear//(r: 40, g: 43, b: 53)
        navController.navigationController?.tabBarController?.tabBar.barTintColor = UIColor(r: 39, g: 40, b: 45)
        navController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.clear], for: .normal)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -6, right: 0)
        
        if #available(iOS 11.0, *) {
            navController.navigationBar.prefersLargeTitles = false
            navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(r: 221, g: 221, b: 221), NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 40) ??             UIFont.systemFont(ofSize: 30)]
        } else {
            // Fallback on earlier versions
        }
        return navController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
