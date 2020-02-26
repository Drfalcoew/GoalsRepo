//
//  AppDelegate.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/6/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let backgroundImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "background")
        return img
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
       
        window = UIWindow(frame: UIScreen.main.bounds)
        //window?.addSubview(backgroundImage)
        window?.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        let mainController = ViewController() as UIViewController
        let navigationController = UINavigationController(rootViewController: mainController)
        navigationController.navigationBar.tintColor = UIColor(r: 40, g: 43, b: 53)
        navigationController.navigationBar.isTranslucent = false
        mainController.title = "Sower"
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        //backgroundImage.frame = window?.frame ?? UIScreen.main.bounds
        
//        //FirebaseConfiguration.shared.analyticsConfiguration.setAnalyticsCollectionEnabled(false)
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.addSubview(backgroundImage)
//        backgroundImage.frame = window?.frame ?? UIScreen.main.bounds
//        //window?.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

