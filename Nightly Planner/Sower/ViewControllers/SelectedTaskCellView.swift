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
        img.layer.masksToBounds = true
        img.isHidden = true
        img.alpha = 0
        img.layer.zPosition = 0
        return img
    }()
    
    var daysPassedLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Days since creation: "
        return lbl
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
    
    var categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Goal: "
        lbl.numberOfLines = 2
        return lbl
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
        }
        daysPassedLabel.text = "Days since creation: \(daysTaken ?? 0)"
        
        
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
                    categoryLabel.text = "Goal: \(goals[i].value(forKeyPath: "name")!)"
                    goalImage.image = UIImage(named: "tree_\(3)")
                    UIView.animate(withDuration: 0.5) {
                        self.goalImage.alpha = 1.0
                    }
                    return
                }
                i += 1
            }
        } else {
            categoryLabel.text = "No connected Goal"
        }
        
        print(name)
    }
    
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(titleView)
        titleView.titleLabel.addSubview(completedIcon)
        self.containerView.addSubview(daysPassedLabel)
        self.containerView.addSubview(completedIcon)
        self.containerView.addSubview(categoryLabel)
        self.view.addSubview(goalImage)
        self.view.addSubview(deleteButton)
        self.view.addSubview(completeButton)
    }
    
    func setupConstraints() {
        let y = (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035
        self.containerView.frame = CGRect(x: self.view.frame.width * 0.05, y: y, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.4)

        
        heightAnchor_0 = titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8.5)
        heightAnchor_0?.isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor, constant: 0).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        titleView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0).isActive = true
        
        heightAnchor_1 = completedIcon.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 2.5/5)
        heightAnchor_1?.isActive = true
        completedIcon.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10).isActive = true
        completedIcon.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        completedIcon.widthAnchor.constraint(equalTo: self.completedIcon.heightAnchor, multiplier: 1.0).isActive = true
        
        heightAnchor_2 = daysPassedLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 4/5)
        heightAnchor_2?.isActive = true
        daysPassedLabel.topAnchor.constraint(equalTo: self.completedIcon.bottomAnchor, constant: 0).isActive = true
        daysPassedLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        daysPassedLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        heightAnchor_3 = categoryLabel.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 4/5)
        heightAnchor_3?.isActive = true
        categoryLabel.topAnchor.constraint(equalTo: self.daysPassedLabel.bottomAnchor, constant: 0).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: self.view.frame.width * 0.1).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        deleteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        deleteButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        completeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        completeButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        completeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        completeButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        goalImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
        goalImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        goalImage.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: 0).isActive = true
        goalImage.widthAnchor.constraint(equalTo: self.goalImage.heightAnchor, multiplier: 1).isActive = true
    }
    
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
            action = UIAlertAction(title: "Complete", style: UIAlertAction.Style.default) { (_) in
                //self.promptComplete(indexPath: indexPath)
                self.removeTask(arg: 0)
            }
        } else {
            action = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                //self.promptDelete(indexPath: indexPath)
                self.removeTask(arg: 1)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        myAlert.addAction(action)
        myAlert.addAction(cancel)
        present(myAlert, animated: true, completion: nil)
    }
    
    
    func removeTask(arg: Int) {
        
        if arg == 0 {
            completedIcon.image = UIImage(named: "checkmark")
        } else {
            completedIcon.image = UIImage(named: "delete_Red")
        }
        
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
    }
    
    func animateTask() {
        let constraints : [NSLayoutConstraint?] = [heightAnchor_0, heightAnchor_1, heightAnchor_2, heightAnchor_3]
        var i = 0
        
        for view in self.containerView.subviews {
            constraints[i]?.isActive = false
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            i += 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.15, options: .curveEaseIn, animations: {
            self.containerView.frame.size.height = 0
            self.containerView.alpha = 0
            self.containerView.frame.origin.y = 0
            self.deleteButton.frame.origin.y = self.view.frame.height + self.deleteButton.frame.height
            self.completeButton.frame.origin.y = self.view.frame.height + self.completeButton.frame.height
            self.goalImage.frame.origin.y += self.goalImage.frame.size.height
            self.goalImage.alpha = 0
            self.view.layoutIfNeeded()
        }) { (true) in
            self.navigationController?.customPopToRoot()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
