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

class SelectedTaskCellView : UIViewController {
    
    var selectedTask : Int?
    var tasks : [NSManagedObject] = [NSManagedObject]()
    var goals : [NSManagedObject] = [NSManagedObject]()
    var task_routine : Bool?
    var name : String = ""
    
    var date: String?
    var completed: Bool?
    var daysTaken: Int?
    var category : UUID?
    var goalIndex : Int?
    
    var containerView : UIView = UIView()
    
    var heightAnchor_0 : NSLayoutConstraint?
    var heightAnchor_1 : NSLayoutConstraint?
    var heightAnchor_2 : NSLayoutConstraint?
    var heightAnchor_3 : NSLayoutConstraint?
    
    var goalImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        //img.layer.masksToBounds = false
        img.isHidden = true
        img.alpha = 0
        img.layer.zPosition = 1
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOffset = CGSize(width: 5, height: 25.0)
        img.layer.shadowOpacity = 0.25
        img.layer.shadowRadius = 5.0
        return img
    }()
    
    var goalImageView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(r: 75, g: 80, b: 120).cgColor
        view.layer.borderWidth = 10
        view.isHidden = true
        view.alpha = 0.5
        return view
    }()
    
    var goalName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = ""
        lbl.alpha = 0.3
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        return lbl
    }()
    
    var goalLevel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = ""
        lbl.numberOfLines = 1
        return lbl
    }()
    
    var daysPassedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.text = ""
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
        lbl.backgroundColor = .green
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
    
    let deleteButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Delete Task", for: .normal)
        btn.setTitleColor(UIColor(r: 240, g: 240, b: 240), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 20.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 0
        btn.addTarget(self, action: #selector(handleButtonPress(sender:)), for: .touchUpInside)
        btn.layer.zPosition = 1
        return btn
    }()
    
    let completeButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(r: 89, g: 255, b: 89)
        btn.setTitle("Complete Task", for: .normal)
        btn.setTitleColor(UIColor(r: 75, g: 80, b: 120), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 20.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 1
        btn.addTarget(self, action: #selector(handleButtonPress(sender:)), for: .touchUpInside)
        btn.layer.zPosition = 1
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGoals()
        setupAttributes()
        setupNavigation()
        setupViews()
        setupConstraints()
    }

    func setupGoals() {
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
    
    func setupNavigation() {
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
    }
    
    func setupAttributes() {

        titleView.titleLabel.text = name
        
        daysTaken = date?.toDate()?.days(from: Date())
        if daysTaken != nil {
            daysTaken = daysTaken! * -1
            if daysTaken! == 1 {
                daysPassedLabel.text = "\(daysTaken ?? 0) day"
            } else {
                daysPassedLabel.text = "\(daysTaken ?? 0) days"
            }
        }
        
        
        
        if task_routine! {
            titleView.subLabel_0.text = "One-time task"
            titleView.subLabelImage.image = UIImage(named: "task")
            titleView.subLabelImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        } else {
            titleView.subLabel_0.text = "Routine task"
            titleView.subLabelImage.image = UIImage(named: "routine")
            titleView.subLabelImage.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        }
        
        if category != nil {
            var i = 0
            for goal in goals {
                if goal.value(forKeyPath: "id") as? UUID == category {
                    goalImage.isHidden = false
                    goalIndex = i
                    goalName.text = (goals[i].value(forKeyPath: "name")!) as? String
                    
                    goalImage.image = UIImage(named: "tree_\(goals[i].value(forKeyPath: "level")!)")
                    goalImageView.isHidden = false
                    goalLevel.text = "Level: \(goals[i].value(forKeyPath: "level")!)"
                    UIView.animate(withDuration: 0.5) {
                        self.goalImage.alpha = 1.0
                    }
                    return
                }
                i += 1
            }
        } else {
            goalName.text = "No connected Goal"
        }
        
        print(name)
    }
    
   
    
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(titleView)
        self.containerView.addSubview(spacerView)
        spacerView.addSubview(completedIcon)
        spacerView.addSubview(daysPassedLabel)
        
        
        self.view.addSubview(goalName)
        //self.view.addSubview(goalLevel)
        self.view.addSubview(goalImageView)
        self.view.addSubview(goalImage)
        self.view.addSubview(deleteButton)
        self.view.addSubview(completeButton)
        
        //self.goalImageView.layer.cornerRadius = self.view.frame.height * 10
    }
    
    func setupConstraints() {
        let y = (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035
        self.containerView.frame = CGRect(x: self.view.frame.width * 0.05, y: y, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.2)

        
        heightAnchor_0 = titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5)
        heightAnchor_0?.isActive = true
        titleView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        titleView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0).isActive = true
        
        spacerView.topAnchor.constraint(equalTo: self.titleView.topAnchor, constant: 0).isActive = true
        spacerView.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 0).isActive = true
        spacerView.leftAnchor.constraint(equalTo: self.titleView.rightAnchor, constant: 0).isActive = true
        spacerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        
        completedIcon.topAnchor.constraint(equalTo: self.titleView.topAnchor, constant: 0).isActive = true
        completedIcon.centerXAnchor.constraint(equalTo: self.spacerView.centerXAnchor, constant: 0).isActive = true
        completedIcon.widthAnchor.constraint(equalTo: self.spacerView.widthAnchor, multiplier: 0.5).isActive = true
        heightAnchor_1 = completedIcon.heightAnchor.constraint(equalTo: self.completedIcon.widthAnchor, multiplier: 1.0)
        heightAnchor_1?.isActive = true

        
        heightAnchor_2 = daysPassedLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 3/5)
        heightAnchor_2?.isActive = true
        daysPassedLabel.topAnchor.constraint(equalTo: self.completedIcon.bottomAnchor, constant: -8).isActive = true
        daysPassedLabel.widthAnchor.constraint(equalTo: self.completedIcon.widthAnchor, multiplier: 1.5).isActive = true
        daysPassedLabel.centerXAnchor.constraint(equalTo: self.completedIcon.centerXAnchor, constant: 0).isActive = true
        
        deleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        completeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        completeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        completeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        completeButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        goalImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
        goalImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        goalImageView.bottomAnchor.constraint(equalTo: self.goalImage.bottomAnchor, constant: 0).isActive = true
        goalImageView.widthAnchor.constraint(equalTo: self.goalImageView.heightAnchor, multiplier: 1).isActive = true
        goalImageView.layer.cornerRadius = self.view.frame.height * 0.11
        
        
        goalImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.5/4).isActive = true
        goalImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        goalImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        goalImage.widthAnchor.constraint(equalTo: self.goalImage.heightAnchor, multiplier: 1).isActive = true
        
        heightAnchor_3 = goalName.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 3/5)
        heightAnchor_3?.isActive = true
        goalName.topAnchor.constraint(equalTo: self.goalImageView.bottomAnchor, constant: 10).isActive = true
        goalName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        goalName.centerXAnchor.constraint(equalTo: self.goalImage.centerXAnchor, constant: -5).isActive = true
        
       /* goalLevel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: 0).isActive = true
        goalLevel.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: -5).isActive = true
        goalLevel.heightAnchor.constraint(equalTo: self.goalImage.heightAnchor, multiplier: 1/5).isActive = true
        goalLevel.rightAnchor.constraint(equalTo: self.goalImage.leftAnchor, constant: -5)
    */}
    
    @objc func handleButtonPress(sender: UIButton) {
        var arg : String
        if sender.tag == 0 {
            arg = "Delete"
        } else {
            arg = "Complete"
        }
        selectGoalAlert(indexPath: selectedTask!, complete_Delete: arg)
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
    
    
    func removeTask(arg: Int) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
            }
              
        let managedContext = appDelegate.persistentContainer.viewContext
              
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
              
        
        
        //fetchRequest.predicate = NSPredicate(format:"markedCell = %@", "user")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            // Or delete first object:
            print(results)
            if results.count > 0 {
                managedContext.delete(results[selectedTask!])
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateTask()
        }
        UserDefaults.standard.set(true, forKey: "taskCreated")
        UserDefaults.standard.set(true, forKey: "taskDeleted")
        ViewController().index = selectedTask!
    }
    
    func animateTask() {
        let constraints : [NSLayoutConstraint?] = [heightAnchor_0, heightAnchor_1, heightAnchor_2, heightAnchor_3]
        var i = 0
        
        for view in self.containerView.subviews {
            constraints[i]?.isActive = false
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            i += 1
        }
        
        UIView.animate(withDuration: 2.5, delay: 0.15, options: .curveEaseIn, animations: {
            self.containerView.frame.size.height = 0
            self.containerView.alpha = 0
            self.containerView.frame.origin.y = 0
            self.deleteButton.frame.origin.y = self.view.frame.height + self.deleteButton.frame.height
            self.completeButton.frame.origin.y = self.view.frame.height + self.completeButton.frame.height
            self.goalImage.frame.origin.x += self.goalImage.frame.size.width + 50
            self.goalImage.alpha = 0
            self.goalLevel.frame.origin.x -= self.view.frame.size.width / 2
            self.goalName.frame.origin.x -= self.view.frame.size.width / 2
            self.view.layoutIfNeeded()
        }) { (true) in
            self.navigationController?.customPopToRoot()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
