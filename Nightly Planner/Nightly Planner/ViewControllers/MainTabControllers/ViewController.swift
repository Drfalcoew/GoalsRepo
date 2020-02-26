//
//  ViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/6/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
//import GoogleMobileAds
import AVFoundation
import UserNotifications

class ViewController: UIViewController, GADInterstitialDelegate {
    
    var userName : String = String()
    var audioPlayer : AVAudioPlayer?
    var shortTermGoals = [GoalAttributes?]()
    var longTermGoals = [LongTermGoalAttributes?]()
    var viewXAnchor : NSLayoutConstraint?
    var db : Firestore?
    var longTermCount : Int?
    var goalCategories = [Any]()
    var longTermZero = "longTerm_Zero"
    var longTermOne = "longTerm_One"
    var x : CGFloat?
    var sort : Int?
    var loaded : Bool? = false
    var adView: GADInterstitial!
    //var indexPathRow : Int!
    var y : Int?
    var collectionCellCount : Int?
    var addGoal : Bool = false
    var collectionView : UICollectionView!
    var shortTermCell : Int? = 0
    var premium : Bool?
    
    var firstGoalOfDay : Bool?
    var weeklyChart : [Int] = [1, 2, 3, 4, 5, 6, 7]  // Goals completed in last 7 days
    var weeklyDay : Int?
    var postDate : String?
    var previousDate : Date?
    var goalsCompleted : Int = 0
    
    var tap : UITapGestureRecognizer?
    var routineComplete : Bool?
    
    var name : String?
    var icon : Int?
    var subTotalArray : [Double] = [Double]()
    
    //var indexIconDict = [Int: Int?]()
    var iconDaysRDict = [Int: Int?]()
    var longTermDictionary = [Int : String]()
    
    var window: UIWindow?
    let cellId = "cellId"

    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let routineView : RoutineViewSubclass = {
        let view = RoutineViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.alpha = 0
        view.layer.cornerRadius = 15
        return view
    }()
    
    var addGoalImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Add")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.tintImageColor(color: .white)
        return img
    }()
    
    lazy var addGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 44, g: 53, b: 70)
        button.layer.zPosition = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.titleLabel?.numberOfLines = 1
        
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.alpha = 0.0
        button.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return button
    }()
    
    
    let badgeIcon : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "badge")
        view.isHidden = false
        return view
    }()
    
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let swordView : UIImageView = {
        let view = UIImageView()
        view.alpha = 0
        view.image = UIImage(named: "GreatSword")
        return view
    }()
    
    let completedView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "completedGoal")
        img.alpha = 0
        img.layer.zPosition = 10
        
        return img
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.checkGoalCreation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            badgeIcon.isHidden = true
            
        } else {
            badgeIcon.isHidden = false
        }
        
        if loaded != true {
            SetupDatabase()
        }
        
        if let x = self.navigationController?.viewControllers.count {
            if x > 3 {
                self.navigationController?.viewControllers.removeFirst(1)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(self.selectRoutineGoal))
        self.view.tag = 0
        
        UserDefaults.standard.set(nil, forKey: "iconInt")
        y = UserDefaults.standard.integer(forKey: "Notifications")
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateNotifications), name: Notification.Name("updateNotifications"), object: nil)
        
        addGoalButton.layer.cornerRadius = (self.view.frame.height * 0.082352) / 2
        
        
        
        CheckIfUserIsLoggedIn()
        checkLoginDates()
        setupViews()
        setupCollectionView()
        SetupNavigation()
        //SetupDatabase()
        SetupConstraints()
    }
    
    func checkPremium() {
        if self.premium != true {
            
        }
    }
    
    func checkLoginDates() { //for weeklyChart
        let firstDaySkipped : Int?
        let lastDaySkipped : Int?
        //weeklyDay = UserDefaults.standard.integer(forKey: "weeklyDay")
        
        postDate = Date().formatted
        print("PostDate = ", postDate!)
        
        if let x = UserDefaults.standard.string(forKey: "Date"), let weeklyDay = UserDefaults.standard.integer(forKey: "weeklyDay") as? Int { // Previous Date is !nil
            self.weeklyDay = weeklyDay
            previousDate = x.toDate() //assigning our local variable in order for use
            print("PrevDATE ", previousDate!.formatted)
            print("TodDate -1 ", Date().dayBefore.formatted) // "previousDate" is last recorded login date
            if previousDate?.formatted != Date().formatted && previousDate?.formatted != Date().dayBefore.formatted { // if last logged date != today or yesterday's date // CHECKING IF ATLEAST 1 DAY HAS BEEN SKIPPED
                let daysSkipped = Date().days(from: previousDate!) // how many days skipped
                
                print("x Date = ", daysSkipped)
                
                if daysSkipped >= 1 && daysSkipped <= 6 {  // will be greater than or equal to 1 if there has been atleast 1 skipped day // The only way it will go else is if it's > 7
                    firstDaySkipped = weeklyDay //assigning to last weeklyDay
                    var y = weeklyDay
                    if weeklyDay + daysSkipped <= 7 {
                        lastDaySkipped = weeklyDay + daysSkipped
                        for i in 0 ..< daysSkipped - 1 {
                            y = y + 1
                            print("Line 209", i)
                            
                        }
                        self.weeklyDay = weeklyDay + daysSkipped
                        UserDefaults.standard.set(weeklyDay + daysSkipped, forKey: "weeklyDay")
                    } else { // 5day = 5day + 3skip - 7dayWeek, = 1day
                        var y = weeklyDay
                        y = y + daysSkipped - 7
                        lastDaySkipped = y
                        self.weeklyDay = y
                        UserDefaults.standard.set(y, forKey: "weeklyDay")
                    }
                } else {
                    print("DATE > 1 week")
                    firstDaySkipped = 0
                    lastDaySkipped = 0
                    UserDefaults.standard.set(0, forKey: "weeklyDay")
                    self.weeklyDay = 0
                } // user hasn't logged in in over 1 week
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.updateSkippedDaysInDatabase(first: firstDaySkipped!, last: lastDaySkipped!)
                }
                UserDefaults.standard.set(Date().formatted, forKey: "Date") // assigning new "PrevDate"
            } else { print("(Date ) User has logged in today and or yesterday")
                if previousDate?.formatted == Date().dayBefore.formatted { // User logged in yesterday
                    var y : Int
                    if weeklyDay < 6 {
                        y = weeklyDay + 1
                        print("Date , Line 232, adding to 1")
                    } else {
                        print("Date , Line 232, resetting to 1")
                        y = 0 // reset if at end of the week
                    }
                    self.weeklyDay = y
                    
                    UserDefaults.standard.set(y, forKey: "weeklyDay")
                    setupNewWeeklyDay()
                }// update weeklyDay +1 if user logged in yesterday
            }
            print("WeeklyDay Date = ", weeklyDay)
            print("Previous Date = ", previousDate!.formatted as Any)
            print("Previous Date + 1 ", previousDate!.dayAfter.formatted)
            UserDefaults.standard.set(Date().formatted, forKey: "Date") // assigning new "PrevDate"
        } else { // first login ?
            UserDefaults.standard.set(0
                , forKey: "weeklyDay")
            self.weeklyDay = 0
            UserDefaults.standard.set(postDate, forKey: "Date") // Initializing Date to today for 1st time
            UserDefaults.standard.synchronize()
        }
    }
    
    func updateSkippedDaysInDatabase(first: Int, last: Int) {
        if let uid = Auth.auth().currentUser?.uid { // check if user is authenticated

            let completionDB = db?.collection("users").document(uid).collection("weeklyChart").document("weeklyChart")
            
            var range : Int
            if last < first {
                range = 7 + last - first
            } else if first < last {
                range = last - first
            } else { // if first == last, skipped days >= 7, reset week
                range = 7
            }
            range = range - 1
            
            print("UPDATE Range:", range)

            // first = 3, last = 5, range = last - first (2)
            // first 5, last = 3. range = 7 + last - first (5)
            
            var weeklyDayCase : String = "day_\(first)"
            var x = first
            
            
            completionDB?.getDocument(completion: { (doc, err) in
                
                if let doc = doc {
                    print("UPDATE : ", doc)
                    for _ in 0...range {
                        weeklyDayCase = "day_\(x)"
                        print("UPDATE : ", weeklyDayCase)
                        completionDB?.updateData([weeklyDayCase : 0])
                        if first < 6 {
                            x += 1
                        } else {
                            x = 0
                        }
                    }
                }
            })
        }
        
    }
    
    func setupGreeting() {
        if let uid = Auth.auth().currentUser?.uid {
            print("TESTING!", uid)
            

            db?.collection("users").document(uid).getDocument(completion: { (document, error) in
                print("TESTING!!")
                
                if let document = document, document.exists {
                    for (key, value) in document.data()! {
                        switch key {
                        case "userName":
                            self.greetingView.subLabel_0.text = "Hi, \(value as! String)"
                            self.userName = (value as? String) ?? "Unable to get name"
                            print("TESTING!!!")

                            break
                        case "email":
                            UserDefaults.standard.set(value as? String, forKey: "Email")
                            UserDefaults.standard.synchronize()
                            print("TESTING!!!!")

                            break
                        case "premium":
                            self.premium = value as? Bool //assign gets called after check
                            if self.premium == true {
                                UserDefaults.standard.set(true, forKey: "premium")
                            } else {
                                UserDefaults.standard.set(false, forKey: "premium")
                            }
                            UserDefaults.standard.synchronize()
                            break
                        default: break
                        }
                    }
                }
            })
        }
        
        UserDefaults.standard.set(self.userName, forKey: "Name")
        UserDefaults.standard.synchronize()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        //let minutes = calendar.component(.minute, from: date)
        if hour < 12 {
            greetingView.titleLabel.text = "Good Morning!"
        } else if hour < 18 {
            greetingView.titleLabel.text = "Good Afternoon!"
        } else if hour < 21 {
            greetingView.titleLabel.text = "Good Evening!"
        } else if hour < 24 {
            greetingView.titleLabel.text = "Good Night!"
        }
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    
    @objc func updateNotifications() {
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            
            
                if #available(iOS 10.0, *) {
                    let content = UNMutableNotificationContent()
                    
                    var list : String = String()
                    var count = 1
                    let maxCount = shortTermGoals.count // highest value will = 4
                    
                    
                    if maxCount > 0 {
                        for item in shortTermGoals {
                            if count != maxCount {
                                list += ("\(item?.name ?? " "), ")
                            } else {
                                list += ("\(item?.name ?? " ")")
                            }
                            count += 1
                        }
                        if maxCount == 1 {
                            content.title = "Good Morning! You have \(maxCount) incomplete goal!"
                        } else {
                            content.title = "Good Morning! You have \(maxCount) incomplete goals!"
                        }
                        content.body = "\(list)"
                    } else {
                        content.title = "Good Morning!"
                        content.body = "Set your goals for today."
                    }
                    
                    
                    content.categoryIdentifier = "notificationOne"
                    
                    
                    var dateComponents = DateComponents()
                    dateComponents.calendar = Calendar.current
                    dateComponents.hour = 10
                    dateComponents.minute = 00
                    
                    
                    //notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
                    
                    let date = Calendar.current.date(from: dateComponents)
                    let triggerInput = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
                    let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInput, repeats: true)
                    
                   
                    
                    
                    //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
                    let request = UNNotificationRequest(identifier: "NotificationOne", content: content, trigger: trigger)
                    
                    let notificationCenter = UNUserNotificationCenter.current()
                    
                    DispatchQueue.main.async {
                        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["NotificationOne"])
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        notificationCenter.add(request) { (error) in
                            if error != nil {
                                // handle errors
                            } else {
                                //
                            }
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    let notification = UILocalNotification()
                    var list : String = String()
                    var count = 1
                    let maxCount = shortTermGoals.count // highest value will = 4
                    
                    
                    if maxCount > 0 {
                        for item in shortTermGoals {
                            if count != maxCount {
                                list += ("\(item?.name ?? " "), ")
                            } else {
                                list += ("\(item?.name ?? " ")")
                            }
                            count += 1
                        }
                        if maxCount == 1 {
                            notification.alertTitle = "Good Morning! You have \(maxCount) incomplete goal."
                        } else {
                            notification.alertTitle = "Good Morning! You have \(maxCount) incomplete goals."
                        }
                        notification.alertBody = "\(list)"
                    } else {
                        notification.alertTitle = "Good Morning!"
                        notification.alertBody = "Set your goals for today."
                    }
                    
                    
                    var dateComponents = DateComponents()
                    dateComponents.calendar = Calendar.current
                    dateComponents.hour = 10
                    dateComponents.minute = 0
                    let date = Calendar.current.date(from: dateComponents)
                    
                    notification.fireDate = date
                    notification.repeatInterval = .day
                    UIApplication.shared.cancelLocalNotification(notification)
                    //UIApplication.shared.cancelAllLocalNotifications()
                    UIApplication.shared.scheduledLocalNotifications = [notification]
            }
        }
    }
    
    func interstitialAd() {
        var adCount = UserDefaults.standard.integer(forKey: "ad")
        adCount = adCount + 1
        UserDefaults.standard.set(adCount, forKey: "ad")
        UserDefaults.standard.synchronize()
        
        if adCount % 10 == 0 { // every 5 page turns, open an ad
            //showAd()
        }
    }
    
    func checkGoalCreation() {
        if UserDefaults.standard.bool(forKey: "goalCreated") == true {
            UserDefaults.standard.set(false, forKey: "goalCreated")
            self.SetupDatabase()
            if UserDefaults.standard.bool(forKey: "firstGoal") == true {
                //setupNotificationsAlert()
                UserDefaults.standard.set(false, forKey: "firstGoal")
            }
        }
    }
    
    func setupNotificationsAlert() {
        let myAlert = UIAlertController(title: "Your first goal was created!", message: "Now turn on notifications to stay focused!", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.navigationController?.customPush(viewController: RequestNotifications())
        }
        let skip = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        myAlert.addAction(optIn)
        myAlert.addAction(skip)
        present(myAlert, animated: true, completion: nil)
    }
    
    func showAd() {
        adView = GADInterstitial(adUnitID: "ca-app-pub-8752347849222491/1365265751")
        adView.load(GADRequest())
        adView.delegate = self
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if adView.isReady {
            adView.present(fromRootViewController: self)
            
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func setupViews() {
        
        self.view.addSubview(greetingView)
        self.view.addSubview(routineView)
        
       /*self.view.addSubview(achievementView)
        self.achievementView.addSubview(achievementViewSeparator)
        self.achievementView.addSubview(dailyGoalCount)
        self.achievementView.addSubview(dailyLogin) */
        
        
        
    }
    
    func CheckIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil { //if user is not logged in
            navigationController?.customPush(viewController: LoginController())
        }
        else {
            if (Auth.auth().currentUser?.uid) != nil { //if user is logged in
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "uid") //assign user id to key "uid"
            }
        }
    }
    
    
    
    
    func checkDailyLogin() {
        
        var dailyLog = 1
        let today = Date().formatted
        
        if let uid = Auth.auth().currentUser?.uid {
            let dailyLogRef = db?.collection("users").document(uid).collection("dailyLogin").document("loginData")
            dailyLogRef?.getDocument(completion: { (document, err) in
                if let document = document, document.exists {
                    
                    for (key, value) in document.data()! {
                        switch key {
                        case "dailyLog":
                            dailyLog = value as! Int
                            //self.dailyLogin.text = "Daily Login: \(dailyLog)"
                            //self.dailyLogin.isHidden = false
                            break
                        case "logDate":  // check if user has already logged in today
                            if today != value as! String {  // new login date
                                dailyLog = dailyLog + 1
                                dailyLogRef?
                                    .setData([
                                        "logDate" : today,
                                        "dailyLog" : dailyLog
                                        ])
                                self.alert(message: "Daily Login")
                                
                                // reset routine completion to false
                                UserDefaults.standard.set(false, forKey: "routineComplete")
                                self.firstGoalOfDay = true
                                UserDefaults.standard.set(true, forKey: "firstGoalOfDay")
                                self.routineComplete = false
                                UserDefaults.standard.synchronize()
                                
                                /*self.dailyLogin.text = "Daily Login: \(dailyLog)"
                                self.dailyLogin.isHidden = false*/
                                
                            } else {
                                //user already logged in today
                                print("User already logged in \(today).")
                            }
                            break
                        default: break
                        }
                    }
                    
                    if err != nil {
                        print(err?.localizedDescription ?? "ERROR")
                    }
                    
                    
                } else {  // First Log in
                    dailyLogRef?
                        .setData([
                            "dailyLog" : dailyLog,
                            "logDate" : today
                            ])
                    print("Login data added successfully. Daily Login: \(dailyLog)")
                    
                    self.subscribeAlert()
                }
            })
        }
    }
    
    
    
    
    func SetupDatabase() {
        db = Firestore.firestore()
        let settings = db?.settings
        //settings?.areTimestampsInSnapshotsEnabled = true
        db?.settings = settings!
        
        setupGreeting()
        checkDailyLogin()
        getShortTerm()
        checkStatus()
    }
    
    func checkStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.getRoutineGoal()
            self.checkPremium()
        }
    }
    
    
    func getRoutineGoal() {
        
        if let uid = Auth.auth().currentUser?.uid {
            routineComplete = UserDefaults.standard.bool(forKey: "routineComplete")
            
            let docRef = db?.collection("users").document(uid).collection("routine").document("routine") // Get ShortTerm
            docRef?.getDocument(completion: { (document, err) in
                if let document = document, document.exists {
                    //add tap gesture on routineView
                    self.routineView.addGestureRecognizer(self.tap!)
                    for (key, value) in document.data()! { // ROUTINE GOAL == TRUE
                        switch key {
                        case "goalName":
                            self.routineView.titleLabel.text = value as! String
                            break
                        case "icon":
                            if value != nil {
                                //self.routineView.categoryImageView
                                //self.routineView.categoryImageView
                            }
                            break
                        case "time":
                            self.routineView.timeRemainingLabel.text = value as! String

                        default: break
                        }
                    }
                    

                    // initial label colorize of either red or green, incomplete or complete, respectively.
                    if self.routineComplete == true {
                        self.routineView.completionLabel.text = "Complete"
                        self.routineView.completionLabel.textColor = UIColor(r: 89, g: 89, b: 255)
                    } else {
                        self.routineView.completionLabel.text = "Incomplete"
                        self.routineView.completionLabel.textColor = UIColor(r: 255, g: 89, b: 89)
                    }

                } else {
                    //remove tap gesture on routineView
                    if self.premium == false {
                        self.routineView.titleLabel.text = "Requires Premium"
                        self.routineView.nonPremiumCover.isHidden = false
                    } else if self.premium == true {
                        self.routineView.titleLabel.text = "No Routine"
                        self.routineView.nonPremiumCover.isHidden = true

                    }
                }
            })
            
            if let window = UIApplication.shared.keyWindow {
                if window.frame.height > 700 {
                    print("in 550 A")
                    routineView.titleLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
                } else {
                    print("in 550 B")
                    routineView.titleLabel.font = UIFont.boldSystemFont(ofSize: 26.0)
                }
            }
            
            if routineView.titleLabel.text?.count ?? 35 < 30 {
                routineView.titleLabel.numberOfLines = 1
            }
        }
    }

 
    func getShortTerm() {
        if let uid = Auth.auth().currentUser?.uid {
            shortTermGoals.removeAll()
            
            let docRef = db?.collection("users").document(uid).collection("shortTerm") // Get ShortTerm
            docRef?.getDocuments { (document, error) in
                if let document = document, document.isEmpty == false {
                    //var goal: GoalAttributes = []
                    
                    for item in document.documents {
                        var goal = GoalAttributes(snapshot: item)
                        goal.ref = item.documentID
                        self.shortTermGoals.append(goal)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        if self.addGoal != true {
                            self.collectionCellCount = self.shortTermGoals.count
                        } else {
                            self.collectionCellCount = self.shortTermGoals.count + 1
                        }
                        self.layoutSpacerView(goalCount: self.shortTermGoals.count)
                    }
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        UIView.animate(withDuration: 1.00, delay: 0.0, options: .curveEaseOut, animations: {
                            self.routineView.alpha = 1.0
                            self.collectionView.alpha = 1
                            if self.loaded != true {
                               // self.spacerView.center.x -= self.view.frame.width
                                self.loaded = true
                            }
                        }, completion: nil)
                        
                    }
                    
                } else {
                    print("SHORT TERM DOCUMENT does not exist")
                    UIView.animate(withDuration: 1.0, animations: {
                        self.collectionView.alpha = 1
                        self.addGoalButton.alpha = 1
                        self.routineView.alpha = 0.9
                        if self.loaded != true {
                           // self.spacerView.center.x -= self.view.frame.width
                            self.loaded = true
                        }
                    })
                }
            }
        }
    }
    
    func layoutSpacerView(goalCount: Int) {
        
        var goalCount = goalCount
        
        let x = self.view.frame.height * 0.8 / 8.5
        let spaceBetweenCells = goalCount * 10
        
        //spacerView.frame.size.height = CGFloat(Int(x) * goalCount + spaceBetweenCells)
        print("Changing spacerView frameHeight to \(CGFloat(Int(x) * goalCount * spaceBetweenCells))")
        
        print("GOAL COUNT: \(goalCount)")
        if goalCount == 4 && shortTermGoals.count == 4 {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                self.addGoalButton.alpha = 0
            }, completion: nil)
            
        } else {
            if addGoalButton.alpha == 0 {
                UIView.animate(withDuration: 1.25, delay: 0.5, options: .curveEaseIn, animations: {
                    self.addGoalButton.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func subscribeAlert() {
        let myAlert = UIAlertController(title: "Thanks for Registering!", message: "Opt-in to our newsletter for even more great stuff!", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "Opt-in", style: UIAlertAction.Style.default, handler: self.subscribeUser)
        let skip = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            self.welcomeAlert()
        }
        myAlert.addAction(optIn)
        myAlert.addAction(skip)
        present(myAlert, animated: true, completion: nil)
    }
    
    func welcomeAlert() {
        let myAlert = UIAlertController(title: "Welcome to QuestLine!", message: "Start by creating a daily goal. You're only allowed 4 max for focus reasons, so only add the most important.", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "More info", style: UIAlertAction.Style.default, handler: self.handleMoreInfo)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        //myAlert.addAction(optIn)
        myAlert.addAction(ok)
        present(myAlert, animated: true, completion: nil)
    }
    
    func selectGoalAlert(goalTitle: String, indexPath: IndexPath) {
        let myAlert = UIAlertController(title: goalTitle, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        
        let complete = UIAlertAction(title: "Complete Goal", style: UIAlertAction.Style.default) { (_) in
            self.promptComplete(indexPath: indexPath)
        }
        
        let delete = UIAlertAction(title: "Delete Goal", style: .destructive) { (_) in
            self.promptDelete(indexPath: indexPath)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        myAlert.addAction(complete)
        myAlert.addAction(delete)
        myAlert.addAction(cancel)
        present(myAlert, animated: true, completion: nil)
    }
    
    @objc func selectRoutineGoal() {
        let myAlert = UIAlertController(title: "Daily Routine", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        if routineComplete != true {
            let complete = UIAlertAction(title: "Complete Task", style: UIAlertAction.Style.default) { (_) in
                self.routineComplete = true
                self.routineView.completionLabel.textColor = UIColor(r: 125, g: 200, b: 180)
                self.routineView.completionLabel.text = "Complete"
                
                UserDefaults.standard.set(true, forKey: "routineComplete")
                UserDefaults.standard.synchronize()
            }
            myAlert.addAction(complete)
        } else {
            myAlert.message = "Routine is complete for today. Great job!"
        }
        
        let delete = UIAlertAction(title: "Delete Routine", style: .destructive) { (_) in
            self.promptDelete(indexPath: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        myAlert.addAction(delete)
        myAlert.addAction(cancel)
        present(myAlert, animated: true, completion: nil)
    }
    
    
    
    func handleMoreInfo(alert: UIAlertAction) {
        navigationController?.customPush(viewController: moreInfoViewController())
    }
    
    func subscribeUser(alert: UIAlertAction) {
        if let email = Auth.auth().currentUser?.email {
            db?.collection("subscribedUsers").addDocument(data: ["Email" : email])
            self.welcomeAlert()
        } else {
            self.alert(message: "Could not register email into our newsletter list.  Please try again later in settings.")
        }
    }
    
    func SetupNavigation() {
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 40, g: 43, b: 53)]
        
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButton.imageView?.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
        if #available(iOS 9.0, *) {
            settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
            settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        } else {
            settingsButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        settingsButton.contentMode = .scaleAspectFit
        if y != 1 {
            settingsButton.addSubview(badgeIcon)
            badgeIcon.centerYAnchor.constraint(equalTo: settingsButton.topAnchor, constant: 0).isActive = true
            badgeIcon.centerXAnchor.constraint(equalTo: settingsButton.rightAnchor, constant: 0).isActive = true
            badgeIcon.widthAnchor.constraint(equalTo: settingsButton.widthAnchor, multiplier: 1).isActive = true
            badgeIcon.heightAnchor.constraint(equalTo: settingsButton.heightAnchor, multiplier: 1).isActive = true
            badgeIcon.isHidden = false
        }
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
    }
        
    lazy var showMenu : ShowMenu = {
        let showMenu = ShowMenu()
        showMenu.viewController = self
        return showMenu
    }()
    
    @objc func showSettings() {
        showMenu.Settings()
    }
    
    
    
    func setupTutorial() {
        
    }
    
    
    //                                      TABLE VIEW SETUP
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width) - (self.view.frame.width * 0.025) , height: ((self.view.frame.height * 0.80) / 7.5))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor.clear //(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isScrollEnabled = false
        //collectionView.isPagingEnabled = true
        collectionView.layer.zPosition = 2
        
        
        self.collectionView.register(ShortTermCell.self, forCellWithReuseIdentifier: "custom")
        
        self.view.addSubview(collectionView)
        self.view.addSubview(addGoalButton)
        self.addGoalButton.addSubview(addGoalImage)
    }
  
    
    func handleLogout(sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.customPush(viewController: LoginController())
        } catch let logoutError {
            print("Error signing out, error: \(logoutError.localizedDescription)")
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
    
   
    
    
    @objc func handleAddGoal() {
        self.navigationController?.customPush(viewController: CreateGoal())
    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.date(from: date) // replace Date String
    }
    
    
    func completeFunc(indexPath: IndexPath) {
        
        let cell = self.collectionView.cellForItem(at: indexPath) as? ShortTermCell

        var goalName : String
        var ref : String
        
       /* if shortTermGoals.count == 4 {
            indexPathRow = indexPath.row
        } else {
            indexPathRow = indexPath.row - 1
        }*/
        
        if let x = shortTermGoals[indexPath.row] {
            goalName = x.name!
            ref = x.ref!
            
            self.shortTermGoals[indexPath.row]?.completed = true
            cell?.daysTaken.text = "Complete!"
            cell?.daysTaken.textColor = UIColor(r: 40, g: 43, b: 53)
            cell?.daysTaken.isHidden = false
            goalsCompleted = UserDefaults.standard.integer(forKey: "goalsCompleted") ?? 0
            goalsCompleted = goalsCompleted + 1
            UserDefaults.standard.set(goalsCompleted, forKey: "goalsCompleted")
            print(goalsCompleted)
            //delete goal and move to profile
        }
    }
    
    func setupNewWeeklyDay() {
        if let uid = Auth.auth().currentUser?.uid { // check if user is authenticated
            var weeklyDayCase : String = "day_\(weeklyDay!)"

            let completionDB = db?.collection("users").document(uid)
            let weeklyChartDB = completionDB?.collection("weeklyChart").document("weeklyChart")
            weeklyChartDB?.getDocument(completion: { (document, error) in
                if let document = document, document.exists {
                    for (key, value) in document.data()! {
                        switch key {
                        case weeklyDayCase:
                            weeklyChartDB?.updateData([weeklyDayCase : 0])
                            break
                        default: break
                        }
                    }
                }
            })
        }
    }
    
    func saveCompletedGoal(indexPath: IndexPath) {
        var completedCount : Int = 0
        var dailyCompletedCount : Int = 0
        var completedImbededCount : Int = 0
        var weeklyDayCase : String = "day_\(weeklyDay!)"
        // weeklyDay
        if let x = shortTermGoals[indexPath.row] {  // check if shortTermGoal exists
            if let uid = Auth.auth().currentUser?.uid { // check if user is authenticated
                let completionDB = db?.collection("users").document(uid)
                if let x = x.icon { // shortTerm goal is imbeded into longTerm
                    
                    let imbededDB = completionDB?.collection("longTerm").document("\(x)")
                    imbededDB?.getDocument(completion: { (document, error) in
                        if let document = document, document.exists {
                            print("line 840", x)
                            for (key, value) in document.data()! {
                                print("line 842", key)
                                switch key {
                                case "completed":
                                    completedCount = value as! Int
                                    print("CompletedCount: ", value)
                                    imbededDB?.updateData(["completed" : completedCount + 1])
                                    
                                    break
                                default: break
                                }
                            }
                        }
                    })
                } else {
                    print("x.icon == nil", x.icon)
                }
                let weeklyChartDB = completionDB?.collection("weeklyChart").document("weeklyChart")
                
                weeklyChartDB?.getDocument(completion: { (document, error) in
                    if let document = document, document.exists {
                        print("line 840", x)
                        for (key, value) in document.data()! {
                            print("line 842", key)
                            switch key {
                            case weeklyDayCase:
                                print("CompletedCount: ", value)
                                print("Line 996", self.firstGoalOfDay)

                                if self.firstGoalOfDay == true {
                                    print("Line 996", self.firstGoalOfDay)
                                    weeklyChartDB?.updateData([weeklyDayCase : 0])
                                    weeklyChartDB?.updateData([weeklyDayCase : 1])
                                } else {
                                    dailyCompletedCount = value as! Int
                                    weeklyChartDB?.updateData([weeklyDayCase : dailyCompletedCount + 1])
                                }
                                break
                            default: break
                            }
                        }
                    }
                })
                completionDB?.getDocument(completion: { (document, error) in //add +1 to count for any type of goal
                    if let document = document, document.exists {
                        for (key, value) in document.data()! {
                            switch key {
                            case "completed":
                                completedCount = value as! Int
                                completionDB?.updateData(["completed" : completedCount + 1])
                                print("CompletedCount : \(value)")
                                break
                            default: break
                            }
                        }
                    }
                })
                
                
                if x.icon != nil { // CHECK IF GOAL IS IMBEDED IN LONGTERM GOAL
                    completionDB?.collection("completed").document("imbededShort")
                        .collection("\(x.icon!)")
                        .addDocument(data: [
                        "goalName" : x.name ?? "Could not load data",
                        "daysTaken" : x.daysTaken ?? 0,
                        "completedDate" : (postDate ?? nil) as Any
                        ])
                } else {
                    db?
                        .collection("users") // users
                        .document(uid) // id
                        .collection("completed") // longTerm
                        .addDocument(data: [
                            "goalName" : x.name ?? "Could not load data",
                            "daysTaken" : x.daysTaken ?? 0
                            ])
                }
            }
        }
    }
    
    
    func completedAnimation(indexPath: IndexPath) {
        
        self.completeFunc(indexPath: indexPath)
        
        
        if let window = UIApplication.shared.keyWindow {
            
            completedView.alpha = 0.0
            blackView.alpha = 0
            
            window.addSubview(blackView)
            window.addSubview(completedView)
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.completedView.alpha = 1
                self.blackView.alpha = 0.5
            }) { (nil) in
                UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseIn, animations: {
                    self.completedView.alpha = 0
                    self.blackView.alpha = 0
                }, completion: { (nil) in
                    window.willRemoveSubview(self.completedView)
                    window.willRemoveSubview(self.blackView)
                    self.completedView.removeFromSuperview()
                    self.blackView.removeFromSuperview()
                })
            }
            
            self.saveCompletedGoal(indexPath: indexPath)
            self.deleteFunc(indexPath: indexPath)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.firstGoalOfDay = false
                UserDefaults.standard.set(false, forKey: "firstGoalOfDay")
            }

        }
    }
    
    
    func promptDelete(indexPath: IndexPath?) {
        let myAlert = UIAlertController(title: "Delete Goal?", message: "Are you sure you want to delete this goal?", preferredStyle: UIAlertController.Style.alert)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if let indexPath = indexPath {
                self.deleteFunc(indexPath: indexPath)
            } else {
                self.deleteRoutine()
                self.routineComplete = false
                UserDefaults.standard.set(false, forKey: "routineComplete")
                UserDefaults.standard.synchronize()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(deleteAction)
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func promptComplete(indexPath: IndexPath) {
        let myAlert = UIAlertController(title: "Complete Goal?", message: "This goal will be moved to the completed tab in your profile.", preferredStyle: UIAlertController.Style.alert)
        let completeAction = UIAlertAction(title: "Complete", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.completedAnimation(indexPath: indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(completeAction)
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func deleteRoutine() {
        if let uid = Auth.auth().currentUser?.uid {
            let completedGoalRef = db?.collection("users")
                .document(uid)
                .collection("routine") // Get LongTerm
                .document("routine")
            completedGoalRef?.delete(completion: { (err) in
                if err != nil {
                    self.alert(message: "An error occurred while attempting to delete.")
                } else {
                    self.routineView.clear()
                    self.routineView.gestureRecognizers?.removeAll()
                }
            })
        }
    }
    
    func deleteFunc(indexPath: IndexPath) {
        var ref : String
        
        if let x = shortTermGoals[indexPath.row] {
            ref = x.ref!
            if let uid = Auth.auth().currentUser?.uid {
                let completedGoalRef = db?.collection("users")
                    .document(uid)
                    .collection("shortTerm") // Get LongTerm
                    .document("\(ref)")
                completedGoalRef?.delete(completion: { (err) in
                    if err != nil {
                        self.alert(message: "An error occurred while attempting to delete row.")
                    } else {
                        self.shortTermGoals.remove(at: indexPath.row)
                        if self.shortTermGoals.count + 1 != 4 {
                            self.collectionView.deleteItems(at: [indexPath])
                        }
                        self.collectionView.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.updateNotifications()
                            self.layoutSpacerView(goalCount: self.shortTermGoals.count)
                        }
                    }
                })
            }
        }
    }
    
    //                                      COLLECTION VIEW SETUP
    
    @objc @available(iOS 10.0, *)
    func listNotification(_ sender: Any) {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        })
        
    }
    
    func SetupConstraints() {
        
        blackView.frame = self.view.frame
        completedView.frame = CGRect(x: 0, y: view.bounds.midY - view.frame.width * 0.43 / 2, width: view.frame.width, height: view.frame.width * 0.43)
       
        
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2, constant: 0).isActive = true
        
        
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        routineView.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: 10).isActive = true
        routineView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/5).isActive = true
        routineView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        routineView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        addGoalButton.rightAnchor.constraint(equalTo: self.collectionView.rightAnchor, constant: -15).isActive = true
        addGoalButton.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 0).isActive = true
        addGoalButton.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7/8.5).isActive = true
        addGoalButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7/8.5).isActive = true
        
        addGoalImage.centerXAnchor.constraint(equalTo: self.addGoalButton.centerXAnchor, constant: 0).isActive = true
        addGoalImage.centerYAnchor.constraint(equalTo: self.addGoalButton.centerYAnchor, constant: 0).isActive = true
        addGoalImage.widthAnchor.constraint(equalTo: self.addGoalButton.widthAnchor, multiplier: 0.8).isActive = true
        addGoalImage.heightAnchor.constraint(equalTo: self.addGoalButton.heightAnchor, multiplier: 0.8).isActive = true
        
    }
}

@available(iOS 10.0, *)
class NotificationService: UNNotificationServiceExtension {

    
    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler:
        @escaping (UNNotificationContent) -> Void) {
        
        print("INSIDE NOTIFICATION SERVICE CLASS")
        let userInfo = request.content.userInfo
        let customID = userInfo["custom-payload-id"] as? String
        
        
        UNUserNotificationCenter.current()
            .getDeliveredNotifications { notifications in
                let matching = notifications.first(where: { notify in
                    let existingUserInfo = notify.request.content.userInfo
                    let id = existingUserInfo["notificationOne"] as? String
                    return id == customID
                })
                
        }
    }
}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
   /* func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ShortTermCell
        
        //selectGoalAlert(goalTitle: cell.titleLabel.text ?? "", indexPath: indexPath)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return shortTermGoals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorRGB = 240
        UIApplication.shared.applicationIconBadgeNumber = shortTermGoals.count
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "custom", for: indexPath) as! ShortTermCell
        cell.contentView.alpha = 0
        
        
        if self.shortTermGoals.isEmpty == false { // safeGuard, because it returns nil when cells are reloaded
        
            
            
               // self.indexPathRow = indexPath.row
            
            if let x = self.shortTermGoals[indexPath.row] {
                cell.titleLabel.text = x.name
                if x.name?.count ?? 15 < 10 {
                    cell.titleLabel.numberOfLines = 1
                }
                
                if let icon = x.icon {
                    /*cell.categoryView.image = UIImage(named: "\(icon)")
                    cell.categoryView.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
                    cell.categoryView.isHidden = false*/
                } else {
                    //cell.categoryView.isHidden = true
                    
                }
                
                
                if x.completed != true {
                    let x = getDate(date: x.date!)
                    var daysR = x!.days(from: Date())
                    
                    daysR = daysR * -1
                    
                    cell.daysTaken.text = "\(daysR) DAYS"
                    self.shortTermGoals[indexPath.row]?.daysTaken = daysR
                    
                    
                    if daysR >= 3 {
                        cell.daysTaken.textColor = UIColor(r: 255, g: 89, b: 89)
                    } else {
                        cell.daysTaken.textColor = UIColor(r: 89, g: 255, b: 89)
                    }
                    
                } else {
                    cell.daysTaken.text = "Completed"
                    cell.daysTaken.textColor = UIColor(r: 125, g: 200, b: 180)
                }
            }
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    
    }
}

public extension UINavigationController {
    
    func customPop(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    func customPopToRoot(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popToRootViewController(animated: false)
    }
    
    
    func customPush(viewController vc: UIViewController, transitionType type: String = CATransitionType.reveal.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: CAMediaTimingFunctionName.easeInEaseOut.rawValue))
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}

extension UIImageView {
    
    func tintImageColor(color: UIColor) {
        guard let image = image else { return }
        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {
    
    func toDate () -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMd yy")
        //dateFormatter.dateFormat = "MMd"
        //dateFormatter.timeStyle = .none
        //dateFormatter.timeStyle = .short
        return dateFormatter.date(from: self)
    }
}

extension Date {
    
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMd YYYY")
        //formatter.timeStyle = .none
        return  formatter.string(from: self as Date)
    }
    
    func getDay(days: Int) -> Date {
        
        
        return Calendar.current.date(byAdding: .day, value: days, to: noon)!
    }
    
    func toString(withFormat format: String = "MM/dd/yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let strMonth = dateFormatter.string(from: self)
        
        return strMonth
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}




