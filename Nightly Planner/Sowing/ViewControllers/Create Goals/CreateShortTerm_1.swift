//
//  CreateShortTerm_1.swift
//  Nightly Planner
//
//  Created by Drew Foster on 7/27/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
//import Firebase
import UserNotifications
import CoreData


class CreateShortTerm_1: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var tasks : [NSManagedObject] = []
    var goals : [NSManagedObject] = []
        
    var selectedGoal : Goal?
    var goalType : Int = Int()
    var postDate : String = ""
    var time : String?
    var y : Int? // notifications enabled, T or F
    var goalText : String = ""
    var goalColor : Int?
    var category : Int?
    
    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.titleLabel.text = "Select Goal Type"
        view.subLabel_0.text = "Where will this improve?"
        view.subLabel_0.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()

    
    let okButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Complete", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.alpha = 0.25
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
        
    let cellId = "cellId"
    
    
    var collectionView : UICollectionView!
    
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
        postDate = Date().formatted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.title = "Goal Category"
                
        y = UserDefaults.standard.integer(forKey: "Notifications")
        
        setupCollectionView()
        SetupNavigation()
        setupViews()
        setupConstraints()
    }
    
    
    func SetupNavigation() {
        var done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleAddGoal))
        done.tintColor = UIColor(r: 221, g: 221, b: 221)
        done.isEnabled = true
        self.navigationItem.rightBarButtonItem = done
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width * 0.23, height: self.view.frame.width * 0.23)
        
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = .clear
        collectionView.alpha = 1
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GoalTypeCell.self, forCellWithReuseIdentifier: cellId)
    }
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GoalTypeCell
        cell.alpha = 0
        cell.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        cell.goalCategoryIcon.image = UIImage(named: "goalType_\(indexPath.row)")
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                cell.alpha = 1
            })
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.height * 0.8
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath.row: ", indexPath.row)
        self.goalColor = indexPath.row
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 75, g: 80, b: 120)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.okButton.alpha = 1.0
        self.okButton.isUserInteractionEnabled = true
        
        self.category = indexPath.row
      }
    
    
    func setupViews() {
        
        self.view.addSubview(greetingView)
        self.view.addSubview(okButton)
        self.view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 8).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.okButton.topAnchor, constant: -25).isActive = true
        
    }
    
    
    @objc func handleAddGoal() {
        handleDismissGoal()
        let vc = ViewController()
        self.navigationController?.customPush(viewController: vc)
        UserDefaults.standard.setValue(true, forKey: "taskCreated")
        if UserDefaults.standard.string(forKey: "firstTaskCreated") == nil {
            UserDefaults.standard.set(true, forKey: "firstTaskCreated")
        }
    }
    
    func handleDismissGoal() {
        
        print("Non routine")
        let vc = ViewController()
        
        vc.shortTermCell = 0
        vc.addGoal = false
        vc.collectionCellCount = vc.tasks.count
        
        addTask(name: goalText, date: postDate, routine: goalType == 1 ? true : false, category: category ?? 4)
    }
    
    func addTask(name: String, date: String, routine: Bool, category : Int) {
        
        let date = Date() // getting raw date
        let newTask : [String : Any?] = ["name" : name, "date" : date, "completedDate" : nil, "routine" : routine, "category" : category, "active" : true]

        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
          NSEntityDescription.entity(forEntityName: "Goal",
                                     in: managedContext)!
        
        let task = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        task.setValuesForKeys(newTask)
        
        do {
          try managedContext.save()
          tasks.append(task)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func setupNotification(hour : Int, min : Int, name: String, AMPM : String) {
        var hour = hour
        if AMPM == "PM" {
            hour = hour + 12 // converting to 24 hour clock
        }
        if y == 1 {
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                
                // do not trigger if it has been completed. toggle not to trigger after completion == true
               
                content.title = "Daily Routine!"
                content.body = name

                content.categoryIdentifier = "routine"
                
               
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = hour
                dateComponents.minute = min
                
                
                //notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
                
                let date = Calendar.current.date(from: dateComponents)
                let triggerInput = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
                let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInput, repeats: true)
                
                
                
                
                //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "routine", content: content, trigger: trigger)
                
                let notificationCenter = UNUserNotificationCenter.current()
                
                DispatchQueue.main.async {
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: ["routine"])
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    notificationCenter.add(request) { (error) in
                        if error != nil {
                            // handle errors
                            print("ROUTINE : ", error)
                        } else {
                            //
                            print("ROUTINE : ADDED SUCC")
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
                let notification = UILocalNotification()
                
                print("ROUTINE : INSIDE IF AVAIL -10")

                notification.alertTitle = "Good Morning!"
                notification.alertBody = "Set your goals for today."
                
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = hour
                dateComponents.minute = min
                let date = Calendar.current.date(from: dateComponents)
                
                notification.fireDate = date
                notification.repeatInterval = .day
                UIApplication.shared.cancelLocalNotification(notification)
                //UIApplication.shared.cancelAllLocalNotifications()
                UIApplication.shared.scheduledLocalNotifications = [notification]
            }
        }
    }
    
    
    func displayLoginAlert(){
        let myAlert = UIAlertController(title: "Please Login", message: "Please login or register to use this feature", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        let loginAction = UIAlertAction(title: "Login", style: UIAlertAction.Style.default, handler: handleLogout)
        myAlert.addAction(cancelAction)
        myAlert.addAction(loginAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func handleLogout(sender: Any) {
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(myAlert, animated: true, completion: nil)
    }
    
}

    
extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
}

