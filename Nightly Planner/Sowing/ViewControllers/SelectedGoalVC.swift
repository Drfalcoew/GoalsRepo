//
//  SelectedTaskCellView.swift
//  Sower
//
//  Created by Drew Foster on 3/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SelectedGoalVC : UIViewController {

    var selectedTask : Int?
    var tasks : [NSManagedObject] = [NSManagedObject]()
    var goals : [NSManagedObject] = [NSManagedObject]()
    var user : [NSManagedObject?] = [NSManagedObject]() // switching to UserDefaults.std
    var task_routine : Bool?
    var name : String = ""
    
    var consistency : Int?
    var date: String?
    var completed: Bool?
    var daysTaken: Int?
    var category : Int?
    var goalIndex : Int?
    var active : Bool?
    
    var containerView : UIView = UIView()
    
    var heightAnchor_0 : NSLayoutConstraint?
    var heightAnchor_1 : NSLayoutConstraint?
    var heightAnchor_2 : NSLayoutConstraint?
    var heightAnchor_3 : NSLayoutConstraint?
    
    var categoryImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "routine")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.borderWidth = CGFloat(2)
        img.layer.borderColor = UIColor.gray.cgColor
        img.backgroundColor = UIColor(r: 75, g: 80, b: 120)

        return img
    }()
    
    var routineBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = CGFloat(2)
        btn.alpha = 0.5
        btn.tag = 1
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.backgroundColor = UIColor.clear//(r: 40, g: 43, b: 53)
        return btn
    }()
    
    
    var goalTypeLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.alpha = 0.5
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var daysPassedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.alpha = 0.5
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var activeLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.alpha = 0.5
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var spacerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    var completedIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = false
        img.image = UIImage(named: "pending")
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        img.layer.shadowOpacity = 0.5
        img.layer.shadowRadius = 5.0
        return img
    }()
    
    var categoryView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    let titleView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.titleLabel.lineBreakMode = .byTruncatingTail
        view.titleLabel.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    let subLabelImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.backgroundColor = .clear
        img.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        img.alpha = 0.5
        return img
    }()
    
    let deleteButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(r: 75, g: 80, b: 120).cgColor
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.setTitle("Delete Task", for: .normal)
        btn.setTitleColor(UIColor(r: 75, g: 80, b: 120), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 0
        btn.addTarget(self, action: #selector(handleButtonPress(sender:)), for: .touchUpInside)
        btn.layer.zPosition = 1
        return btn
    }()
    
    let completeButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.setTitle("Complete Task", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 1
        btn.addTarget(self, action: #selector(handleButtonPress(sender:)), for: .touchUpInside)
        btn.layer.zPosition = 1
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttributes()
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigation() {
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
    }
    
    func setupAttributes() {

        titleView.titleLabel.text = name
        

        if task_routine! {
            goalTypeLabel.text = "Routine task"
            subLabelImage.image = UIImage(named: "routine")
            subLabelImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
            activeLabel.text = "This task is \(active! ? "active." : "complete.")"
            if active == false {
                // grey out complete button
                completeButton.backgroundColor = UIColor(r: 200, g: 200, b: 200)
            }
            
            daysPassedLabel.text = "Days consistent: \(consistency ?? 0)"

        } else {
            goalTypeLabel.text = "One-time task"
            subLabelImage.image = UIImage(named: "task")
            subLabelImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
            
            daysTaken = date?.toDate()?.days(from: Date())
            if daysTaken != nil {
                daysTaken = daysTaken! * -1
                if daysTaken! == 1 {
                    daysPassedLabel.text = "Days taken: \(daysTaken ?? 1) day"
                } else {
                    daysPassedLabel.text = "Days taken: \(daysTaken ?? 0) days"
                }
            }
        }
        
        if category != nil && category != 4 {
            categoryImg.image = UIImage(named: "goalType_\(category!)")
        }
        
        print(name)
    }
    
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(titleView)
        self.view.addSubview(spacerView)
        self.view.addSubview(daysPassedLabel)
        self.view.addSubview(goalTypeLabel)
        self.view.addSubview(activeLabel)
        self.view.addSubview(subLabelImage)
        self.view.addSubview(deleteButton)
        self.view.addSubview(completeButton)
        self.view.addSubview(categoryImg)
    }
    
    func setupConstraints() {
        let y = (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035
        self.containerView.frame = CGRect(x: self.view.frame.width * 0.05, y: y, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.15)
        
        heightAnchor_0 = titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5)
        heightAnchor_0?.isActive = true
        titleView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        titleView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0).isActive = true
        
        spacerView.topAnchor.constraint(equalTo: self.titleView.topAnchor, constant: 0).isActive = true
        spacerView.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 0).isActive = true
        spacerView.leftAnchor.constraint(equalTo: self.titleView.rightAnchor, constant: 0).isActive = true
        spacerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        goalTypeLabel.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0).isActive = true
        goalTypeLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10).isActive = true
        goalTypeLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.4).isActive = true
        goalTypeLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        subLabelImage.leftAnchor.constraint(equalTo: self.goalTypeLabel.rightAnchor, constant: 10).isActive = true
        subLabelImage.centerYAnchor.constraint(equalTo: self.goalTypeLabel.centerYAnchor, constant: 0).isActive = true
        subLabelImage.widthAnchor.constraint(equalTo: goalTypeLabel.heightAnchor, multiplier: 1).isActive = true
        subLabelImage.heightAnchor.constraint(equalTo: goalTypeLabel.heightAnchor, multiplier: 1).isActive = true
        
        daysPassedLabel.topAnchor.constraint(equalTo: self.goalTypeLabel.bottomAnchor, constant: 5).isActive = true
        daysPassedLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10).isActive = true
        daysPassedLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5).isActive = true
        daysPassedLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        activeLabel.topAnchor.constraint(equalTo: self.daysPassedLabel.bottomAnchor, constant: 5).isActive = true
        activeLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10).isActive = true
        activeLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 0.5).isActive = true
        activeLabel.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1/3).isActive = true
        
        categoryImg.centerYAnchor.constraint(equalTo: self.subLabelImage.centerYAnchor, constant: 0).isActive = true
        categoryImg.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0).isActive = true
        categoryImg.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        categoryImg.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        categoryImg.layer.cornerRadius = self.view.frame.width / 9
        
        deleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        completeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        completeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        completeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        completeButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        }
    
    @objc func handleButtonPress(sender: UIButton) {
        var arg : String
        if sender.tag == 0 {
            arg = "Delete"
        } else {
            arg = "Complete"
            if active == false { // goal has already been completed
                alert(title: "Alert", message: "This goal has already been completed today.")
                return
            }
        }
        selectGoalAlert(indexPath: selectedTask!, complete_Delete: arg)
    }
    
    func alert(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }    
    
    func selectGoalAlert(indexPath: Int, complete_Delete: String) {
        let myAlert = UIAlertController(title: "\(complete_Delete) this task?", message: nil, preferredStyle: UIAlertController.Style.alert)
        var action = UIAlertAction()
        
        if complete_Delete == "Complete" {
            self.completedIcon.image = UIImage(named: "checkmark")
            action = UIAlertAction(title: "Complete", style: UIAlertAction.Style.default) { (_) in
                self.removeTask(arg: 0)
            }
        } else {
            self.completedIcon.image = UIImage(named: "delete_Red")
            action = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.removeTask(arg: 1)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            //self.promptDelete(indexPath: indexPath)
            self.completedIcon.image = UIImage(named: "pending")
        }
        myAlert.addAction(action)
        myAlert.addAction(cancel)
        present(myAlert, animated: true, completion: nil)
    }
    
    func getTotalCompleted() -> Int {
        
        let total : Int? = UserDefaults.standard.integer(forKey: "completedGoals")
        return total ?? 0
    }
    
    func setTotalCompleted() {
        
        var total : Int
        total = getTotalCompleted() + 1
        print("total = ", total)
        UserDefaults.standard.setValue(total, forKey: "completedGoals")
        UserDefaults.standard.synchronize()
        
    }
    
    
    func removeTask(arg: Int) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
            }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goal")
        
        print("arg: ", arg)
        
        if (arg == 0) {
            setTotalCompleted()
        }
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            // Or delete first object:
            print(results)
            if results.count > 0 {
                if (arg == 0) && (task_routine == true) && (active == true){
                    // temp disabling active routine; completing routine
                    results[selectedTask!].setValue(false, forKey: "active")
                    results[selectedTask!].setValue(Date(), forKey: "completedDate")
                    results[selectedTask!].setValue(consistency ?? 0 + 1, forKey: "days")
                } else {
                    // deleting goal from Core Data ...
                    managedContext.delete(results[selectedTask!])
                }
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
                
        UserDefaults.standard.set(true, forKey: "taskDeleted")
        ViewController().index = selectedTask!
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = ViewController()
            self.navigationController?.customPush(viewController: vc)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
