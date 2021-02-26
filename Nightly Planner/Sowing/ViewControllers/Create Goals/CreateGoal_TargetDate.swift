//
//  CreateGoal_TargetDate.swift
//  Sower
//
//  Created by Drew Foster on 3/10/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
/*
import Foundation
import UIKit
import UserNotifications
import CoreData



class CreateGoal_TargetDate : UIViewController {
    
    var goalText : String?
    var goalType : Int?
    var y : Int?
    var date : Date?
    
    var goals : [NSManagedObject] = []

    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.titleLabel.text = "Set a deadline for your Goal"
        //view.subLabel_0.text = "Optional"
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let optionalLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "(Optional)"
        lbl.alpha = 0.5
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        lbl.textColor = UIColor.darkGray//(r: 221, g: 221, b: 221)
        return lbl
    }()
    
    let okButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Complete", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.alpha = 1.0
        btn.titleLabel?.textAlignment = .center
        btn.isUserInteractionEnabled = true
        btn.setTitleColor(UIColor(r: 240, g: 240, b: 240), for: .normal)
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
    let datePicker : UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return date
    }()
    
    let dateTextField : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        //view.layer.borderWidth = 0.2
        view.font = UIFont(name: "Helvetica Neue", size: 40)
        view.adjustsFontSizeToFitWidth = true
        view.minimumFontSize = 15
        view.placeholder = "Set Date"
        //view.layer.borderColor = UIColor(r: 75, g: 80, b: 120).cgColor
        view.textColor = UIColor(r: 75, g: 80, b: 120)
        view.textAlignment = .center
        return view
    }()
    
    
    
    let dateContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear// (r: 221, g: 221, b: 221)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
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
        self.tabBarController?.tabBar.isHidden = true
        self.dateTextField.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
//        self.title = "Set Notification"
        
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateShortTerm_0.dismissKeyboard))
        //view.addGestureRecognizer(tap)
        
        SetupNavigation()
        setupViews()
        setupToolbar()
        setupConstraints()
    }
    
    
    func setupConstraints() {
        
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        optionalLbl.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: -10).isActive = true
        optionalLbl.leftAnchor.constraint(equalTo: self.greetingView.leftAnchor, constant: 10).isActive = true
        optionalLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        optionalLbl.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        
        dateContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        dateContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2.5/3).isActive = true
        dateContainerView.heightAnchor.constraint(equalTo: self.dateContainerView.widthAnchor, multiplier: 3/5).isActive = true
        dateContainerView.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 8).isActive = true
        
        
        
       dateTextField.centerYAnchor.constraint(equalTo: dateContainerView.centerYAnchor, constant: 0).isActive = true
       dateTextField.rightAnchor.constraint(equalTo: dateContainerView.rightAnchor, constant: -5).isActive = true
       dateTextField.leftAnchor.constraint(equalTo: dateContainerView.leftAnchor, constant: 5).isActive = true
       dateTextField.heightAnchor.constraint(equalTo: dateContainerView.heightAnchor, multiplier: 1/1.5).isActive = true
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    func SetupNavigation() {
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleAddGoal))
        done.tintColor = UIColor(r: 75, g: 80, b: 120)
        done.isEnabled = true
        self.navigationItem.rightBarButtonItem = done
    }
    
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
       dateTextField.inputAccessoryView = toolbar
    }
    
    func setupViews() {

        dateTextField.inputView = datePicker
        
        //self.view.addSubview(goalName)
        self.view.addSubview(greetingView)
        self.view.addSubview(okButton)
        self.view.addSubview(dateContainerView)
        self.view.addSubview(optionalLbl)
        self.dateContainerView.addSubview(dateTextField)
    }
    
    
    @objc func handleAddGoal() {
        SaveGoal(date: self.date, goalText: self.goalText!)
        let vc = GoalViewController()
        self.navigationController?.customPush(viewController: vc)
    }
    
    func SaveGoal(date: Date?, goalText : String) {
        let date = Date() // getting raw date
        let newGoal : [String : Any] = ["name" : goalText, "target" : date, "creation" : Date(), "complete" : false, "tasks" : 0, "completedTasks" : 0, "level" : 0, "id" : UUID()]
        
        
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let entity =
          NSEntityDescription.entity(forEntityName: "Goal",
                                     in: managedContext)!
        
        let goal = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        goal.setValuesForKeys(newGoal)
        
        do {
          try managedContext.save()
          goals.append(goal)
            UserDefaults.standard.set(true, forKey: "goalCreated")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        print(datePicker.date)
//        if dateTextField.text?.isEmpty ?? false {
//            self.navigationItem.rightBarButtonItem?.tintColor = .gray
//            self.navigationItem.rightBarButtonItem?.isEnabled = false
//            self.okButton.alpha = 0.25
//            self.okButton.isUserInteractionEnabled = false
//            return
//        } else {
//            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 221, g: 221, b: 221)
//            self.navigationItem.rightBarButtonItem?.isEnabled = true
//            self.okButton.alpha = 1.0
//            self.okButton.isUserInteractionEnabled = true
//
//        }
        date = datePicker.date
        print(date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
*/
