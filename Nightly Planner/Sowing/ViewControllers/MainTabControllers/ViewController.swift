//
//  ViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/6/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications
import CoreData

class ViewController: UIViewController {
    
    let lightGray = UIColor(r: 240, g: 240, b: 240)
    var userName : String = String()
    var audioPlayer : AVAudioPlayer?
    var tasks : [NSManagedObject] = [NSManagedObject]()
    var user : [NSManagedObject?] = [NSManagedObject]() // might not need this, switching to UserDefaults
    var localTasks = [GoalAttributes]()
    var viewXAnchor : NSLayoutConstraint?
    var longTermCount : Int?
    var goalCategories = [Any]()
    var longTermZero = "longTerm_Zero"
    var longTermOne = "longTerm_One"
    var x : CGFloat?
    var sort : Int?
    var checkTasks : Bool = false
    //var indexPathRow : Int!
    var y : Int?
    var index : Int = Int()
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
    
    let counterView : GoalCounter = {
        let view = GoalCounter()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.counterView.animatePulsatingLayer()
        Assets().preloadAssets()
        self.counterView.basicAnimation(goals: UserDefaults.standard.integer(forKey: "completedGoals"), total: UserDefaults.standard.integer(forKey: "totalGoals"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
        self.counterView.removeAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            badgeIcon.isHidden = true
        
        } else {
            badgeIcon.isHidden = false
        }
                        
        if let x = self.navigationController?.viewControllers.count {
            if x > 4 {
                self.navigationController?.viewControllers.removeFirst(1)
            }
        }
        
        if UserDefaults.standard.bool(forKey: "taskDeleted") == true {
            organizeLocalTasks()
            UserDefaults.standard.set(false, forKey: "taskDeleted")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Goals"
        
        self.view.tag = 0
        
        UserDefaults.standard.set(nil, forKey: "iconInt")
        y = UserDefaults.standard.integer(forKey: "Notifications")
        
        setupNotificationObservers()
        CheckIfUserIsLoggedIn()
        checkLoginDates()
        setupViews()
        setupCollectionView()
        setupNavigation()
        SetupDatabase()
        setupConstraints()
        
    }
    
    private func setupNotificationObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateNotifications), name: Notification.Name("updateNotifications"), object: nil)
        nc.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    @objc private func handleEnterForeground() {
        counterView.animatePulsatingLayer()
    }
    
    
    func organizeLocalTasks() {
        if index >= 0 && index < 4 && localTasks.count > 0 {
            localTasks.remove(at: index)
        }
        updateCompletedTasks()
    }
    
    func updateCompletedTasks() {
        
        let total : Int? = UserDefaults.standard.integer(forKey: "completedGoals")
        
        
        counterView.goals = total ?? 0
        counterView.setupGoals()
    }
    
    func checkLoginDates() { //for weeklyChart
        let firstDaySkipped : Int?
        let lastDaySkipped : Int?
        //weeklyDay = UserDefaults.standard.integer(forKey: "weeklyDay")
        
        postDate = Date().formatted
        
        if let x = UserDefaults.standard.string(forKey: "Date"), let weeklyDay = UserDefaults.standard.integer(forKey: "weeklyDay") as? Int { // Previous Date is !nil
            self.weeklyDay = weeklyDay
            previousDate = x.toDate() //assigning our local variable in order for use
            if previousDate?.formatted != Date().formatted && previousDate?.formatted != Date().dayBefore.formatted { // if last logged date != today or yesterday's date // CHECKING IF ATLEAST 1 DAY HAS BEEN SKIPPED
                let daysSkipped = Date().days(from: previousDate!) // how many days skipped
                
                
                if daysSkipped >= 1 && daysSkipped <= 6 {  // will be greater than or equal to 1 if there has been atleast 1 skipped day // The only way it will go else is if it's > 7
                    firstDaySkipped = weeklyDay //assigning to last weeklyDay
                    var y = weeklyDay
                    if weeklyDay + daysSkipped <= 7 {
                        lastDaySkipped = weeklyDay + daysSkipped
                        for i in 0 ..< daysSkipped - 1 {
                            y = y + 1
                            
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
                    firstDaySkipped = 0
                    lastDaySkipped = 0
                    UserDefaults.standard.set(0, forKey: "weeklyDay")
                    self.weeklyDay = 0
                } // user hasn't logged in in over 1 week
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.updateSkippedDaysInDatabase(first: firstDaySkipped!, last: lastDaySkipped!)
                }
                UserDefaults.standard.set(Date().formatted, forKey: "Date") // assigning new "PrevDate"
            } else {
                if previousDate?.formatted == Date().dayBefore.formatted { // User logged in yesterday
                    var y : Int
                    if weeklyDay < 6 {
                        y = weeklyDay + 1
                    } else {
                        y = 0 // reset if at end of the week
                    }
                    self.weeklyDay = y
                    
                    UserDefaults.standard.set(y, forKey: "weeklyDay")
                    setupNewWeeklyDay()
                }// update weeklyDay +1 if user logged in yesterday
            }
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

        
        var range : Int
        if last < first {
            range = 7 + last - first
        } else if first < last {
            range = last - first
        } else { // if first == last, skipped days >= 7, reset week
            range = 7
        }
        range = range - 1
        

        // first = 3, last = 5, range = last - first (2)
        // first 5, last = 3. range = 7 + last - first (5)
        
        var weeklyDayCase : String = "day_\(first)"
        var x = first
        
    }
    
    func setupGreeting() {
        
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

    
    @objc func updateNotifications() {
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            
            
                if #available(iOS 10.0, *) {
                    let content = UNMutableNotificationContent()
                    
                    var list : String = String()
                    var count = 1
                    let maxCount = tasks.count // highest value will == 4
                    
                    
                    if maxCount > 0 {
                        for item in tasks {
                            if count != maxCount {
                                //list += ("\(item.name ?? " "), ")
                            } else {
                                //list += ("\(item.name ?? " ")")
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
                    let maxCount = tasks.count // highest value will = 4
                    
                    
                    if maxCount > 0 {
                        for item in tasks {
                            if count != maxCount {
                                //list += ("\(item?.name ?? " "), ")
                            } else {
                                //list += ("\(item?.name ?? " ")")
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
    
    
    func setupNotificationsAlert() {
        let myAlert = UIAlertController(title: "Your first goal was created!", message: "Now turn on notifications to stay focused!", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //self.navigationController?.customPush(viewController: RequestNotifications())
        }
        let skip = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        myAlert.addAction(optIn)
        myAlert.addAction(skip)
        present(myAlert, animated: true, completion: nil)
    }
    
    func setupViews() {
        
        self.view.addSubview(greetingView)
        self.view.addSubview(counterView)
        
    }
    
    func CheckIfUserIsLoggedIn() {
        
    }
    
    
    func checkDailyLogin() {
        
        var dailyLog = 1
        let today = Date().formatted
        
    }
    
    
    
    
    func SetupDatabase() {

        setupGreeting()
        checkDailyLogin()
        getTasks()
    }

    func getTasks() {
        tasks.removeAll()
            

        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        do {
          tasks = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            UIView.animate(withDuration: 1.00, delay: 0.0, options: .curveEaseOut, animations: {
                self.collectionView.alpha = 1
            }, completion: nil)
            
        }
    }
    
    func alert(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    /*func subscribeAlert() {
        let myAlert = UIAlertController(title: "Thanks for Registering!", message: "Opt-in to our newsletter for even more great stuff!", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "Opt-in", style: UIAlertAction.Style.default, handler: self.subscribeUser)
        let skip = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            self.welcomeAlert()
        }
        myAlert.addAction(optIn)
        myAlert.addAction(skip)
        present(myAlert, animated: true, completion: nil)
    }*/
    
    func welcomeAlert() {
        let myAlert = UIAlertController(title: "Welcome to QuestLine!", message: "Start by creating a daily goal. You're only allowed 4 max for focus reasons, so only add the most important.", preferredStyle: UIAlertController.Style.alert)
        let optIn = UIAlertAction(title: "More info", style: UIAlertAction.Style.default, handler: self.handleMoreInfo)
        let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        //myAlert.addAction(optIn)
        myAlert.addAction(ok)
        present(myAlert, animated: true, completion: nil)
    }
    
    func handleMoreInfo(alert: UIAlertAction) {
        navigationController?.customPush(viewController: moreInfoViewController())
    }
    
    func setupNavigation() {
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //settingsButton.imageView?.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
        if #available(iOS 9.0, *) {
            settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
            settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        } else {
            settingsButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        settingsButton.contentMode = .scaleAspectFit
        if y != 1 {
            settingsButton.addSubview(badgeIcon)
            badgeIcon.centerYAnchor.constraint(equalTo: settingsButton.topAnchor, constant: -3).isActive = true
            badgeIcon.centerXAnchor.constraint(equalTo: settingsButton.rightAnchor, constant: 3).isActive = true
            badgeIcon.widthAnchor.constraint(equalTo: settingsButton.widthAnchor, multiplier: 0.8).isActive = true
            badgeIcon.heightAnchor.constraint(equalTo: settingsButton.heightAnchor, multiplier: 0.8).isActive = true
            badgeIcon.isHidden = false
        }
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        let addGoalButton = UIButton(type: .system)
        addGoalButton.setImage(UIImage(named: "Add")?.withRenderingMode(.alwaysOriginal), for: .normal)
        if #available(iOS 9.0, *) {
            addGoalButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
            addGoalButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        } else {
            addGoalButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        addGoalButton.contentMode = .scaleAspectFit
        addGoalButton.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addGoalButton)
        
    }
    
    lazy var goalCount : GoalCounter = {
        let showCount = GoalCounter()
        return showCount
    }()
        
    @objc func showCount() {
        goalCount.setupViews()
    }
    
    lazy var showMenu : ShowMenu = {
        let showMenu = ShowMenu()
        showMenu.viewController = self
        return showMenu
    }()
    
    @objc func showSettings() {
        showMenu.Settings()
    }
    
    func save(key: String, value: Any) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Goal",
                                   in: managedContext)!
      
      let task = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      task.setValue(value, forKeyPath: key)
      
      // 4
      do {
        try managedContext.save()
        tasks.append(task)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    func setupTutorial() {
        
    }
    
    
    //                                      TABLE VIEW SETUP
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width) - (self.view.frame.width * 0.025) , height: (self.view.frame.height * 0.6) / 5.0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor.clear //(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.layer.zPosition = 1
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isScrollEnabled = false
        //collectionView.isPagingEnabled = true
        collectionView.layer.zPosition = 2
        
        
        self.collectionView.register(ShortTermCell.self, forCellWithReuseIdentifier: "custom")
        
        self.view.addSubview(collectionView)
    }
  
    
    func handleLogout(sender: Any) {
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
        if tasks.count < 4 {
            self.navigationController?.customPush(viewController: CreateGoal())
        } else {
            alert(title: "Hey!", message: "Let's focus on the tasks at hand.")
        }
    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.date(from: date) // replace Date String
    }
    
    
    func setupNewWeeklyDay() {
        //reset 0
    }
    
    func saveCompletedGoal(indexPath: IndexPath) {
        var completedCount : Int = 0
        var dailyCompletedCount : Int = 0
        var completedImbededCount : Int = 0
        var weeklyDayCase : String = "day_\(weeklyDay!)"
        // weeklyDay
    }
    
    @objc @available(iOS 10.0, *)
    func listNotification(_ sender: Any) {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests -> () in
            print("\(requests.count) requests -------")
            for request in requests{
                print(request.identifier)
            }
        })
        
    }
    
    func setupConstraints() {
        
        blackView.frame = self.view.frame
        completedView.frame = CGRect(x: 0, y: view.bounds.midY - view.frame.width * 0.43 / 2, width: view.frame.width, height: view.frame.width * 0.43)
                
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        counterView.frame = CGRect(x: 0, y: self.view.frame.height * 0.2, width: self.view.frame.width, height: self.view.frame.height * 0.15)

        
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.56, constant: 0).isActive = true
    
    }
    
    @objc func selectDailyTask(sender: UIButton?, index: Int) {
        var Index : Int
        
        if sender != nil {
            Index = sender!.tag
        } else {
            Index = index
        }

        let vc = SelectedGoalVC()
        
        vc.consistency = self.localTasks[Index].consistency
        vc.selectedTask = Index
        vc.active = self.localTasks[Index].active
        vc.date = self.localTasks[Index].date
        vc.completed = false
        vc.category = self.localTasks[Index].category
        vc.name = self.localTasks[Index].name
        vc.task_routine = self.localTasks[Index].routine
        
        self.navigationController?.customPush(viewController: vc)
    }
}

@available(iOS 10.0, *)
class NotificationService: UNNotificationServiceExtension {

    
    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler:
        @escaping (UNNotificationContent) -> Void) {
        
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
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ShortTermCell
        
        
        selectDailyTask(sender: cell.moreInfo, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if checkTasks {
            if tasks.count <= 0 {
                alert(title: "Add a Goal!", message: "\"By failing to prepare, you are preparing to fail\" - Benjamin Franklin")
            }
        } else { checkTasks = true }
        
        
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UIApplication.shared.applicationIconBadgeNumber = tasks.count
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "custom", for: indexPath) as! ShortTermCell
        cell.contentView.alpha = 0
        
        if self.tasks.isEmpty == false { // safeGuard, because it returns nil when cells are reloaded
            
            let task = tasks[indexPath.row]
            
            cell.moreInfo.tag = indexPath.row
            cell.moreInfo.addTarget(self, action: #selector(selectDailyTask(sender:index:)), for: .touchUpInside)
            
            let name = task.value(forKeyPath: "name") as? String
            let date = task.value(forKeyPath: "date") as? Date
            let dateCompleted = task.value(forKeyPath: "completedDate") as? Date
            let consistency = task.value(forKeyPath: "days") as? Int
            let category = task.value(forKeyPath: "category") as? Int
            let routine = task.value(forKeyPath: "routine") as? Bool
            let active = task.value(forKeyPath: "active") as? Bool
            
            
            self.localTasks.append(GoalAttributes(name: name!, date: date!.formatted, completedDate: dateCompleted?.formatted ?? "nil", completed: false, consistency: consistency ?? 0, category: category, routine: routine ?? false, active: active!))
            
            
            cell.titleLabel.text = name
            if name?.count ?? 15 < 10 {
                    cell.titleLabel.numberOfLines = 1
            }
            print("INDEX PATH: \(indexPath.row): ROUTINE = \(routine)")
            
            if routine == true {
                cell.routineImage.isHidden = false
                let daysFromCompletion = dateCompleted?.days(from: Date())
                
                
                if active == false {
                    // resetting task, greater than 1 day since completion.
                    if (daysFromCompletion ?? 0 < 0) {
                        // reset to active goal
                        alert(title: "Alert", message: "Resetting routine task on row \(indexPath.row)")
                        resetRoutine(item: indexPath.row)
                        if (daysFromCompletion ?? 0 < 1) {
                            resetConsistency(item: indexPath.row)
                        }
                    } else { // less than 1 day.
                        // still inactive
                        cell.titleView.backgroundColor = UIColor(r: 200, g: 200, b: 200)
                        cell.titleLabel.textColor = .white
                        cell.routineImage.tintImageColor(color: .white)
//                        cell.dateLabel.textColor = .darkGray
//                        cell.dateLabelView.backgroundColor = lightGray
                    }
                    
                    
                } else {
                    cell.titleLabel.textColor = UIColor(r: 75, g: 80, b: 120)
                    cell.routineImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
                    cell.titleView.backgroundColor = lightGray
                }
            } else {
                cell.titleLabel.textColor = UIColor(r: 75, g: 80, b: 120)
                cell.titleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                cell.routineImage.isHidden = true
            }
            
            
            
            if let date = date {
                var x = date.toStringAbbreviated()
                x.removeLast(6)
                cell.dateLabel.text = "\(x)"
            }
            
            //let x = getDate(date: x.date!)
            var days = date?.days(from: Date())
        
            days = (days ?? 1) * -1
            
            cell.daysTaken.text = "\(days) DAYS"
          
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    
    }
    
    private func resetConsistency(item: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                results[item].setValue(0, forKey: "days")
                localTasks[item].consistency = 0
            }
            do {
                try managedContext.save()
            } catch {
                print("Failed save request")
                alert(title: "Error", message: "Failed to save request")
            }
        } catch {
            print("Failed fetch request")
            alert(title: "Error", message: "Failed to fetch request")
        }
    }
    
    private func resetRoutine(item: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            // Or delete first object:
            if results.count > 0 {
                results[item].setValue(true, forKey: "active")
                localTasks[item].active = true
            }
            do {
                try managedContext.save()
            } catch {
                print("Failed save request")
            }
        } catch {
            // ... fetch failed, report error
            print("Failed fetch request")
        }
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
    
    func toStringAbbreviated() -> String {
      let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
      return dateFormatter.string(from: self)
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
