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
import CoreData

class FocusViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView : UICollectionView!
    let cellId = "cellId"
    let cellIdShort = "cellIdShort"
    var longTermFocus : [String : Any]?
    var longTermIconIndex = [Int : Int]()
    var completingGoal : Bool?
    var dateNumToggle : Bool = false
    
    var goals : [NSManagedObject] = [NSManagedObject]()
    var tasks : [NSManagedObject] = [NSManagedObject]()
    var localTasks = [GoalAttributes?]()
    var localGoals = [LongTermGoalAttributes?]()
    
    var selectedLongTermGoal : LongTermGoalAttributes!
    var goalIcons : [Int] = []
    var focusIcon : Int?
    var loaded : Bool = false
    var createLongTerm : Bool? = false //maybe change to Int depending on if I have more than one creation cell
    var y : Int?

    
    let goalView = LongTermCellSubclassView()
    
    
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
        let x = UserDefaults.standard.bool(forKey: "goalCreated")
        if x == true {
            setupGoals()
            UserDefaults.standard.set(false, forKey: "goalCreated")
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

        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FocusViewController))
        //focusViewBackground.addGestureRecognizer(tap)
        

        
        setupViews()
        setupCollectionView()
        setupNavigation()
        setupDatabase()
        //setupGreeting()
        setupConstraints()
    }
    
    func getGoals() {
        goals.removeAll()
            

        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        do {
          goals = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            UIView.animate(withDuration: 1.00, delay: 0.0, options: .curveEaseOut, animations: {
                self.collectionView.alpha = 1
                if self.loaded != true {
                   // self.spacerView.center.x -= self.view.frame.width
                    self.loaded = true
                }
            }, completion: nil)
        }
    }
    
    func changeGoalTitle(index: Int) {
        let x = localGoals[index]?.name
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            //self.greetingView.alpha = 0.0
        }) { (true) in
            /*self.greetingView.titleLabel.text = x
            UIView.animate(withDuration: 0.25) {
                self.greetingView.alpha = 1.0
            }*/
        }
        print(x)
    }
    
    func setupGreeting(){
    
    }
    
    func setupViews() {
        
        //self.view.addSubview(greetingView)
    }
    
    func setupConstraints() {
        
        var height = self.view.frame.height / 11 + (navigationController?.navigationBar.frame.height ?? 60)
        
        
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.06).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
    
    func selectGoalAlert(goalTitle: String) {
        let myAlert = UIAlertController(title: goalTitle, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        
        let complete = UIAlertAction(title: "Complete Goal", style: UIAlertAction.Style.default) { (_) in
            //self.completeGoal()
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

        setupGoals()
        if localGoals.count > 0 {
            //greetingView.titleLabel.text = localGoals[0]?.name
        } else {
            //greetingView.titleLabel.text = "Create a Goal"
        }
    }

    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width) * 1, height: ((self.view.frame.height * 0.93)))
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //collectionView.layer.masksToBounds = true
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.clear//(r: 240, g: 240, b: 240)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.layer.zPosition = 2
        
        collectionView.register(LongTermCellSubclassView.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
    }
    
    
    func setupGoals() {
        
        localGoals.removeAll()
        longTermIconIndex.removeAll()
        longTermFocus?.removeAll()
        goalIcons.removeAll()  // CLEANSEEEEEEE

        
        goals.removeAll()
            

        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        do {
          goals = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
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
            //self.handleComplete(indexPath: indexPath)
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
        } else {
            alert(message: "Error getting goal data.")
        }
    }

    func deleteFunc(indexPath : Int) {
        
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
    
    @objc func handleAddGoal() {
        self.navigationController?.customPush(viewController: CreateGoal())
    }
    
    func getDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.date(from: date) // replace Date String
    }
    
    lazy var showSelectedGoal : ShowSelectedGoal = {
        let showGoal = ShowSelectedGoal()
        showGoal.viewController = self
        return showGoal
    }()
    
    @objc func handleSelectedGoal() {
        //showSelectedGoal.animateSelectedGoal()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension FocusViewController {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var completed : CGFloat = 0
        var shortTerm : CGFloat = 0
    
        let goal = goals[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LongTermCellSubclassView
        //cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
         
        //move all of this to another function \/
        let name = goal.value(forKeyPath: "name") as? String
        let dateCreated = goal.value(forKeyPath: "creation") as? Date
        let targetDate = goal.value(forKeyPath: "target") as? Date
        let daysRemaining : Int?
        let completedTasks : CGFloat = goal.value(forKeyPath: "completedTasks") as! CGFloat
        let tasks : CGFloat = goal.value(forKeyPath: "tasks") as! CGFloat
        let complete = goal.value(forKeyPath: "complete")
        let icon = goal.value(forKeyPath: "icon") as! Int
        let level = goal.value(forKey: "level") as! Int
        let id = goal.value(forKeyPath: "id") as! UUID
        
        cell.goalIcon.image = UIImage(named: "tree_4")
        
        if let x = targetDate {
            cell.deadline.text = "\(x.days(from: Date())) days until deadline."
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5, animations: {
                cell.alpha = 1
                self.localGoals.append(LongTermGoalAttributes(name: name!, targetDate: targetDate, completedTasks: completedTasks, icon: icon, totalTasks: tasks, createdDate: dateCreated!, level: level, id: id))
                print("LOCALTASK: ", self.localTasks)

            })
        }
        return cell
    
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            if let cell = self.collectionView.cellForItem(at: indexPath) as? LongTermCellSubclassView {
                cell.goalIcon.tintImageColor(color: .white)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //handleSelectedGoal()
        //showSelectedGoal.view.goalIcon.image = UIImage(named: "tree_0")
        //self.selectedLongTermGoal = localGoals[indexPath.row]
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            print(indexPath?.row as Any)
            changeGoalTitle(index: indexPath!.row)
        }
    }
}
