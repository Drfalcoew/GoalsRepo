//
//  FocusViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/1/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications


class FocusViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView : UICollectionView!
    let cellId = "cellId"
    let cellIdShort = "cellIdShort"
    var longTermFocus : [String : Any]?
    var longTermIconIndex = [Int : Int]()
    var completingGoal : Bool?
    var dateNumToggle : Bool = false
    var longTermGoals = [LongTermGoalAttributes?]()
    var shortTermGoals = [GoalAttributes?]()
    var selectedLongTermGoal : LongTermGoalAttributes!
    var longTermIcons : [Int] = []
    var focusIcon : Int?
    var loaded : Bool = false
    var createLongTerm : Bool? = false //maybe change to Int depending on if I have more than one creation cell
    var premium : Bool?
    var y : Int?

    
    let badgeIcon : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "badge")
        view.isHidden = false
        return view
    }()
    
    let projectsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.titleLabel.font = UIFont.boldSystemFont(ofSize: 55)
        return view
    }()

    
    let spacerView : UIView = {
        let view = UIView()
    
        return view
    }()
    
    let focusNameView : UILabel = {
        let lbl = UILabel()
        //lbl.backgroundColor = UIColor(red: 221, green: 221, blue: 221, alpha: 0.7)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica Neue", size: 40)
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let focusDateView : UILabel = {
        let lbl = UILabel()
        //lbl.backgroundColor = UIColor(red: 221, green: 221, blue: 221, alpha: 0.7)
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.layer.zPosition = 3
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let focusImageView : UIImageView = {
        let img = UIImageView()
        //img.image = UIImage(named: "")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = false
        img.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        return img
    }()
    
    let focusImageBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.alpha = 1
        view.backgroundColor = .clear//UIColor(r: 221, g: 221, b: 221)
        return view
    }()
    
    let focusViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 60, g: 63, b: 73)
        view.layer.cornerRadius = 15
        view.alpha = 0.9
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let daysRemainingLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.backgroundColor = UIColor.clear//(red: 221, green: 221, blue: 221, alpha: 0.7)
        lbl.layer.zPosition = 2
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.alpha = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.text = ""
        return lbl
    }()
    
    let focusView : FocusViewSubclass = {
        let view = FocusViewSubclass()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let longTermStatsView_0 : LongTermStatsSubclass = {
        let view = LongTermStatsSubclass()
        view.backgroundColor = UIColor(r: 70, g: 74, b: 84)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    
    let longTermStatsView_2 : LongTermStatsSubclass = {
        let view = LongTermStatsSubclass()
        view.backgroundColor = UIColor(r: 70, g: 74, b: 84)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
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
        self.tabBarController?.tabBar.isHidden = false
        let x = UserDefaults.standard.bool(forKey: "addedLongTerm")
        if x == true {
            setupLongTerm()
            UserDefaults.standard.set(false, forKey: "addedLongTerm")
        } else {
            print("LongTerm wasn't added")
        }
        collectionView.reloadData()
        
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            badgeIcon.isHidden = true
            
        } else {
            badgeIcon.isHidden = false
        }
        if let x = self.navigationController?.viewControllers.count {
            if x > 3 {
                self.navigationController?.viewControllers.removeFirst(1)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 1

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FocusViewController.toggleGoal))
        focusViewBackground.addGestureRecognizer(tap)
        
        self.premium = UserDefaults.standard.bool(forKey: "premium")

        
        setupViews()
        setupCollectionView()
        setupNavigation()
        setupDatabase()
        //setupGreeting()
        setupConstraints()
    }
    
    func setupGreeting(){
        if self.premium == true {
            greetingView.subLabel_0.text = "\(self.longTermGoals.count)/10 Goals"
        } else {
            greetingView.subLabel_0.text = "\(self.longTermGoals.count)/4 Goals"
        }
    }
    
    func setupViews() {
        greetingView.titleLabel.text = "Goals"
        self.view.addSubview(greetingView)
        
    }
    
    func setupConstraints() {
        
        var height = self.view.frame.height / 11 + (navigationController?.navigationBar.frame.height ?? 60)
        
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3.5, constant: 0).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.height * 0.08).isActive = true
        
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6.0).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 1).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
    }
    
    @objc func toggleGoal() {
        var name : String
        var date : String
        
        name = selectedLongTermGoal.name ?? "Project Name"
        if selectedLongTermGoal.date != "No Date" && selectedLongTermGoal.date != nil && selectedLongTermGoal.date != "" {
            date = selectedLongTermGoal.date!
        } else {
            date = "No Target Date"
        }
        selectGoalAlert(goalTitle: ("\(name)\n\(date)"))
    }
    
    func selectGoalAlert(goalTitle: String) {
        let myAlert = UIAlertController(title: goalTitle, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        
        let complete = UIAlertAction(title: "Complete Goal", style: UIAlertAction.Style.default) { (_) in
            self.completeGoal()
        }
        
        let delete = UIAlertAction(title: "Delete Goal", style: .destructive) { (_) in
            self.handleDelete()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        myAlert.addAction(complete)
        myAlert.addAction(delete)
        myAlert.addAction(cancel)
        present(myAlert, animated: true, completion: nil)
    }
     
    func setupDatabase() {

        setupLongTerm()
    }

    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width) / 2.5, height: ((self.view.frame.width / 2.5)))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor.clear //(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        //collectionView.isPagingEnabled = true
        collectionView.layer.zPosition = 2
        
        collectionView.register(LongTermCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
    }
    
    
    func setupLongTerm() {
        
        longTermGoals.removeAll()
        longTermIconIndex.removeAll()
        longTermFocus?.removeAll()
        longTermIcons.removeAll()  // CLEANSEEEEEEE

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
    
    func deleteAlert(message: String, indexPath: Int) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (_) in
            self.deleteFunc(indexPath: indexPath)
        }
        
        myAlert.addAction(cancelAction)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func completeAlert(message: String, indexPath: Int) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (_) in
            self.handleComplete(indexPath: indexPath)
        }
        
        myAlert.addAction(cancelAction)
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    @objc func handleDelete() {
        print(longTermIconIndex)
        if let x = selectedLongTermGoal.icon {
            if let y = longTermIconIndex[x] {
                deleteAlert(message: "Are you sure you want to delete \(selectedLongTermGoal.name!)", indexPath: y - 1)
            } else {
                alert(message: "Error getting the index of the collection.")
            }
        } else { // longTermIconIndex doesn't re-initialize ************ ERROR
            alert(message: "Error getting goal data.")
        }
    }
    
    @objc func handleComplete(indexPath : Int) {
        if let x = longTermGoals[indexPath] {
        }
        // SAVE & DELETE GOAL
    }

    
    @objc func completeGoal() {
        if let x = selectedLongTermGoal.icon {
            if let y = longTermIconIndex[x] {
                completeAlert(message: "Complete Projects?", indexPath: y - 1)
            }
        }
    }
   
    
    func resetNotification(date: String, name: String) {
        
        
        let x = getDate(date: date)
        let daysR = x?.days(from: Date())
        
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            
            content.title = "Good Morning!"
            if daysR != nil {
                content.body = "Your goal, “\(name)“ expires in \(daysR) days!"
            } else if date != "No Date" {
                content.body = "Your goal, “\(name)“ expires on \(date)!"
            } else {
                content.body = "Today's a great day to start working on your goal, “\(name)“!"
            }
            
            
            content.categoryIdentifier = "notificationOne"
            
            
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 8
            dateComponents.minute = 15
            
            
            //notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
            
            let date = Calendar.current.date(from: dateComponents)
            let triggerInput = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInput, repeats: true)
            
            print("TRIGGERINPUT: \(triggerInput)")
            print("TRIGGER: \(trigger)")
            
            
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "NotificationOne", content: content, trigger: trigger)
            
            let notificationCenter = UNUserNotificationCenter.current()
            
            DispatchQueue.main.async {
                notificationCenter.removeAllPendingNotificationRequests()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                notificationCenter.add(request) { (error) in
                    if error != nil {
                        self.endFunc(succ: false)
                        // handle errors
                    } else {
                        self.endFunc(succ: true)
                        //
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            let notification = UILocalNotification()
            
            notification.alertTitle = "Good Morning!"
            
            if daysR != nil {
                notification.alertBody = "Your goal, “\(name)“ expires in \(daysR) days!"
            } else if date != "No Date" {
                notification.alertBody = "Your goal, “\(name)“ expires on \(date)!"
            } else {
                notification.alertBody = "Today's a great day to start working on your goal, “\(name)“!"
            }
            

            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.hour = 8
            dateComponents.minute = 15
            let date = Calendar.current.date(from: dateComponents)
            
            notification.fireDate = date
            notification.repeatInterval = .day
            UIApplication.shared.cancelAllLocalNotifications()
            UIApplication.shared.scheduledLocalNotifications = [notification]
        }
    }
    
    
    func endFunc(succ: Bool) {
        DispatchQueue.main.async {
            if succ == true {
                self.alert(message: "Notifications are now enabled for this goal.")
            } else {
                self.alert(message: "Error enabling notifications, please try again, or check inside your settings.")
            }
        }
    }
    
    func setupLongTermStats(selectedGoal: LongTermGoalAttributes) {
        
        var date : String
        if selectedGoal.date != "" && selectedGoal.date != nil {
            date = selectedGoal.date!
            let x = getDate(date: date)
            let daysR = x?.days(from: Date())
            if let x = daysR {
                if x >= 0 {
                    date = "\(String(describing: x))"
                } else {
                    date = "Expired"
                }
            }
        } else {
            date = "N/A"
        }
        
        
        longTermStatsView_0.label.text = "goals completed"
        longTermStatsView_0.value.text = "\(Int(selectedGoal.completed!))"
        
        //longTermStatsView_1.label.text = "active goals"
        //longTermStatsView_1.value.text = "\(Int(selectedGoal.shortTerm!))"
        
        longTermStatsView_2.label.text = "days remaining"
        longTermStatsView_2.value.text = date
        
    }
    
    func previewFocus(selectedFocus: LongTermGoalAttributes) {
        
        if loaded != true {
            spacerView.center.x = self.view.frame.width / -2
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.spacerView.center.x = self.view.frame.width / 2
            }, completion: nil)
        }
        
        
        focusImageView.image = UIImage(named: "\(selectedFocus.icon!)")
        focusImageView.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        focusNameView.text = "\(selectedFocus.name!)"
        if selectedFocus.date != "" && selectedFocus.date != nil {
            focusDateView.text = "\(selectedFocus.date!)"
            let x = getDate(date: selectedFocus.date!)
            let daysR = x?.days(from: Date())
            if let x = daysR {
                if x >= 0 {
                    daysRemainingLabel.text = "Expires in \(String(describing: x)) days"
                } else {
                    daysRemainingLabel.text = "Expired"
                }
            }
        } else {
            focusDateView.text = "No target date"
            daysRemainingLabel.alpha = 0
            if focusDateView.alpha != 0.5 {
                UIView.animate(withDuration: 0.5) {
                    self.focusDateView.alpha = 0.5
                }
            }
        }
        
        loaded = true
    }
    
    func reloadData(indexPath: Int) {
        
        if let x = self.longTermGoals[indexPath]?.icon { // REMOVING DELETED INDEX
            print("REMOVING: \(longTermIconIndex[x])")
            self.longTermIconIndex.removeValue(forKey: x)  // removes the correct one by searching through this dictionary, but then reinitializes incorrectly by -1 indexPath.row ERROR !!!!!!
        } // deleting works fine
        
        
        self.longTermGoals.remove(at: indexPath)
        self.collectionView.deleteItems(at: [IndexPath(item: indexPath + 1, section: 0)])
        
        
        for i in 0..<longTermGoals.count { // i = index of LongTermGoals
            if let x = self.longTermGoals[i] { // iterating through longTermGoals
                if let y = x.icon {
                    print("Initializing LONGTERMICONINDEX")
                    self.longTermIconIndex[y] = i + 1 // +1
                }
                print("err cl 1")
            }
            print("error cl 2")
        }
        
        print(self.longTermIconIndex)
    }
    
    
    
    func deleteFunc(indexPath : Int) {
        
    }
    
    func removeNotification(x: Int) {
        if x == 1 {
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                
                content.title = "Good Morning!"
                //content.body = "Your goal, '\(focusName)' expires in \(focusDate) days!"
                
                content.body = "“The Way Get Started Is To Quit Talking And Begin Doing.” – Walt Disney"
                
                content.categoryIdentifier = "notificationOne"
                
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = 8
                dateComponents.minute = 15
                
                
                //notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
                
                let date = Calendar.current.date(from: dateComponents)
                let triggerInput = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
                let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInput, repeats: true)
                
                print("TRIGGERINPUT: \(triggerInput)")
                print("TRIGGER: \(trigger)")
                
                
                //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "NotificationOne", content: content, trigger: trigger)
                
                let notificationCenter = UNUserNotificationCenter.current()
                
                DispatchQueue.main.async {
                    notificationCenter.removeAllPendingNotificationRequests()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    notificationCenter.add(request) { (error) in
                        if error != nil {
                            // handle errors
                        } else {
                            
                        }
                    }
                }
            } else {
                // Fallback on earlier versions
                let notification = UILocalNotification()
                
                notification.alertTitle = "Good Morning!"
                notification.alertBody = "“The Way Get Started Is To Quit Talking And Begin Doing.” – Walt Disney"
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = 8
                dateComponents.minute = 15
                let date = Calendar.current.date(from: dateComponents)
                
                notification.fireDate = date
                notification.repeatInterval = .day
                UIApplication.shared.cancelAllLocalNotifications()
                UIApplication.shared.scheduledLocalNotifications = [notification]
            }
        }
    }
    
    @objc func handleAddGoal(sender: UIButton) {
        createLongTerm = true
        let indexPath = IndexPath(item: longTermGoals.count, section: 0)
        collectionView.reloadItems(at: [indexPath])
    }
    
    @objc func handleHelp() {
        print("Test")
        alert(message: "This is your Projects page.  Start by adding a Project using the button on the bottom left of the page.")
    }
    
    lazy var showMenu : ShowMenu = {
        let showMenu = ShowMenu()
        showMenu.viewController = self
        return showMenu
    }()
    
    @objc func showSettings() {
        showMenu.Settings()
    }
    
    func setupNavigation() {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 40, g: 43, b: 53)]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(createGoal))
        
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //settingsButton.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
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
    
    @objc func createGoal() {

    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.date(from: date) // replace Date String
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension FocusViewController {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return longTermGoals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var completed : CGFloat = 0
        var shortTerm : CGFloat = 0
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LongTermCell
        //cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        if self.longTermGoals.isEmpty == false {
            if let x = self.longTermGoals[indexPath.row] {
                if let iconInt = x.icon {
                    print("Initializing LONGTERMICONINDEX")
                    cell.longTermLabel.text = x.name
                    
                    
                    if x.name?.count ?? 10 > 12 {
                        cell.longTermLabel.numberOfLines = 2
                        print(cell.longTermLabel.text, " is over 12 characters long! Changing to 2 lines.")
                    } else {
                        cell.longTermLabel.numberOfLines = 1
                    }
                    
                    
                    self.longTermIconIndex[iconInt] = indexPath.row
                    cell.goalCategoryIcon.image = UIImage(named: "tree_0")
                    if indexPath.row == 1 {
                        cell.goalCategoryIcon.image = UIImage(named: "tree_3")
                    }
                    //cell.goalCategoryIcon.tintImageColor(color: .white)
                } else {
                    print("ERROR DECLARING ICONINT = X.ICON")
                }
                cell.progressBackgroundView.isHidden = false
                if let a = x.completed, let b = x.shortTerm {
                    completed = a
                    shortTerm = b
                }
                cell.progressBackgroundView.frame = CGRect(x: 0, y: cell.frame.height, width: cell.frame.width, height: 0)
                if completed > 0 && shortTerm > 0 && completed <= shortTerm {
                    var progress = completed / shortTerm  // BUG
                    progress = cell.frame.height * -progress
                    UIView.animate(withDuration: 2.0, delay: 0.2, options: .curveEaseOut, animations: {
                        cell.progressBackgroundView.frame.size.height = progress
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 2.0, delay: 0.2, options: .curveEaseOut, animations: {
                        cell.progressBackgroundView.frame.size.height = -5
                    }, completion: nil)
                }
            }
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5, animations: {
                cell.alpha = 1
            })
        }
        return cell
    
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if let cell = self.collectionView.cellForItem(at: indexPath) as? LongTermCell {
                cell.goalCategoryIcon.tintImageColor(color: .white)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if longTermGoals.isEmpty == false { // not empty
            if indexPath.row == 0 { // selected add goal cell
                if longTermGoals.count < 4 || self.premium == true {

                } else {
                    alert(message: "Maximum Projects reached! Upgrade to premium to unlock more.")
                }
            } else {
            
                self.selectedLongTermGoal = longTermGoals[indexPath.row - 1]
                setupLongTermStats(selectedGoal: selectedLongTermGoal)
                previewFocus(selectedFocus: selectedLongTermGoal)
                
            }
        } else { // 0 longTerm goals
            /*
            let vc = CreateLongTerm()
            vc.longTermIcons = self.longTermIcons
            
            self.navigationController?.customPush(viewController: vc)*/
            
        }
   
    }
}
