//
//  RequestNotifications.swift
//  Sowing
//
//  Created by Drew Foster on 8/4/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
//import Firebase


class RequestNotifications: UIViewController, UNUserNotificationCenterDelegate {
    
    var longTermGoalNames = [String?]()
    var x : Int?
    
    
    let notificationImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "exampleNotification")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.alpha = 0
        img.layer.cornerRadius = 20
        return img
    }()
    
    let okButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Enable notifications", for: .normal)
        btn.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(handleNotification), for: .touchUpInside)
        return btn
    }()
    
    
    
    let dontAllowButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("I'm not dedicated yet", for: .normal)
        btn.titleLabel?.numberOfLines = 2
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.setTitleColor(.gray, for: .normal)
        btn.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
        return btn
    }()
    
    @objc func backToMain() {
        self.navigationController?.customPopToRoot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notifications"
        
        setupViews()
        setupConstraints()
    }
    
    func runAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.notificationImage.alpha = 1
        }
    }
    
    func setupNotificationOne() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil)
        
        self.endFunc(succ: true)
    }
    
    func endFunc(succ: Bool) {
        DispatchQueue.main.async {
            if succ == true {
                self.alert(message: "Thank you. Notifications are now enabled, you will be returned to the home screen.")
            } else {
                self.alert(message: "Error enabling notifications, please try again, or check inside your settings.")
            }
        }
    }
    
    func setupViews() {
        self.view.addSubview(notificationImage)
        self.view.addSubview(okButton)
        self.view.addSubview(dontAllowButton)
    }

    
    func setupConstraints() {
        
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        dontAllowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        dontAllowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        dontAllowButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: 0).isActive = true
        dontAllowButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10, constant: 0).isActive = true
        
        notificationImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.3).isActive = true
        notificationImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0).isActive = true
        notificationImage.heightAnchor.constraint(equalTo: self.notificationImage.widthAnchor, multiplier: 0.28).isActive = true
        notificationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    //registration successful
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successsful registration with token ID: \(tokenString(deviceToken))")
    }
    //Failed registration
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func tokenString(_ deviceToken: Data) -> String {
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes {
            token += String(format: "%02x", byte)
        }
        return token
    }
    
    @objc func handleNotification(for application: UIApplication) {
        x = UserDefaults.standard.integer(forKey: "Notifications")
        
        
        
        if x == 0 {
            //request access
            print("x == 0")
            // iOS 12 support
            if #available(iOS 12, *) {
                
                //print("in ios 12")
                
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in
                    
                    //print("in ios 12 FUNC")

                    guard error == nil else {
                    //Display Error.. Handle Error.. etc..
                    print(error?.localizedDescription)
                    return
                    }
                    
                     if granted {
                        //Do stuff here..
                        print("GRANTED")
                        //Register for RemoteNotifications. Your Remote Notifications can display alerts now :)
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        UserDefaults.standard.set(1, forKey: "Notifications")
                        
                        self.setupNotificationOne()
                    }
                    else {
                        
                        //Handle    user denying permissions..
                        UserDefaults.standard.set(2, forKey: "Notifications")
                        //self.alert(message: "Please consider enabling notifications from your settings app to greatly improve focus")
                    }
                }
            } else if #available(iOS 10, *) { // iOS 10 support
                
                //Notifications get posted to the function (delegate):  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void)"
                
                print("in ios 10")
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    print("in ios 10 FUNC")

                    guard error == nil else {
                        //Display Error.. Handle Error.. etc..
                        return
                    }
                    
                    if granted {
                        //Do stuff here..
                        
                        //Register for RemoteNotifications. Your Remote Notifications can display alerts now :)
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        UserDefaults.standard.set(1, forKey: "Notifications")
                        self.setupNotificationOne()
                        
                    }
                    else {
                        //Handle user denying permissions..
                        UserDefaults.standard.set(2, forKey: "Notifications")
                        self.alert(message: "Please consider enabling notifications from your settings app to greatly improve focus")
                    }
                }
                
                //Register for remote notifications.. If permission above is NOT granted, all notifications are delivered silently to AppDelegate.
                UIApplication.shared.registerForRemoteNotifications()
            }
            else {
                
                print("in ios ELSE")

                let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                UIApplication.shared.registerForRemoteNotifications()
                
                UserDefaults.standard.set(1, forKey: "Notifications")
                
                self.setupNotificationOne()
                

            }

            
        } else if x == 1 {
            print("x == 1")
            self.alert(message: "Notifications are already enabled on this device. Thank you!.")
            // already enabled
            
        } else if x == 2 {
            print("x == 2")
            self.alert(message: "Please enable notifications in settings.")
            // does not allow, present how to re enable
            
        }
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.backToMain()
        })
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
