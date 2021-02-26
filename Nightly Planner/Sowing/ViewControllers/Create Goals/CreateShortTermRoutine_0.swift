//
//  CreateShortTermRoutine_0.swift
//  Nightly Planner
//
//  Created by Drew Foster on 8/19/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications



class CreateShortTermRoutine_0: UIViewController {
    
    var goalText : String?
    var goalType : Int?
    var y : Int?
    var time : String?

    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.titleLabel.text = "Select Notification Time"
        view.subLabel_0.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let okButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.alpha = 0.25
        btn.titleLabel?.textAlignment = .center
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor(r: 40, g: 43, b: 53), for: .normal)
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
    let datePicker : UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .time
        date.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return date
    }()
    
    let dateTextField : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor(r: 40, g: 43, b: 53).cgColor
        view.textColor = UIColor(r: 40, g: 43, b: 53)
        view.textAlignment = .center
        return view
    }()
    
    let setTimeLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Time:"
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
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
        self.title = "Set Notification"
        
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
        
        dateContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        dateContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2.200/3).isActive = true
        dateContainerView.heightAnchor.constraint(equalTo: self.dateContainerView.widthAnchor, multiplier: 1/5).isActive = true
        dateContainerView.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 8).isActive = true
        
        
        dateTextField.centerYAnchor.constraint(equalTo: dateContainerView.centerYAnchor, constant: 0).isActive = true
        dateTextField.rightAnchor.constraint(equalTo: dateContainerView.rightAnchor, constant: -12).isActive = true
        dateTextField.widthAnchor.constraint(equalTo: dateContainerView.widthAnchor, multiplier: 1/2.5).isActive = true
        dateTextField.heightAnchor.constraint(equalTo: dateContainerView.heightAnchor, multiplier: 1/1.5).isActive = true
        
        setTimeLbl.leftAnchor.constraint(equalTo: dateContainerView.leftAnchor, constant: 12).isActive = true
        setTimeLbl.centerYAnchor.constraint(equalTo: dateContainerView.centerYAnchor, constant: 0).isActive = true
        setTimeLbl.heightAnchor.constraint(equalTo: dateContainerView.heightAnchor, multiplier: 1).isActive = true
        setTimeLbl.widthAnchor.constraint(equalTo: dateContainerView.widthAnchor, multiplier: 1/2).isActive =  true
        
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    func SetupNavigation() {
        var done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleAddGoal))
        done.tintColor = .gray
        done.isEnabled = false
        self.navigationItem.rightBarButtonItem = done
    }
    
    
    @objc func updateNotifications(hour: Int, min: Int, name: String) {
        y = UserDefaults.standard.integer(forKey: "Notifications")
        if y == 1 {
            
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                
                content.categoryIdentifier = "notificationRoutine"
                
                content.title = "QuestLine: Routine"
                content.body = name
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.hour = hour
                dateComponents.minute = min
                
                
                //notification.repeatInterval = NSCalendarUnit.CalendarUnitDay
                
                let date = Calendar.current.date(from: dateComponents)
                let triggerInput = Calendar.current.dateComponents([.hour, .minute], from: date ?? Date())
                let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerInput, repeats: true)
                
                print("TRIGGERINPUT: \(triggerInput)")
                print("TRIGGER: \(trigger)")
                
                
                //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "notificationRoutine", content: content, trigger: trigger)
                
                let notificationCenter = UNUserNotificationCenter.current()
                
                DispatchQueue.main.async {
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: ["notificationRoutine"])
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
                
                
                
                notification.alertTitle = "QuestLine: Routine"
                
                notification.alertBody = name
               
                
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
        self.dateContainerView.addSubview(dateTextField)
        self.dateContainerView.addSubview(setTimeLbl)
    }
    
    
    @objc func handleAddGoal() {
        let vc = CreateShortTerm_1()
        vc.time = self.time
        vc.goalType = self.goalType!
        vc.goalText = self.goalText ?? "Unable to get data"
        self.navigationController?.customPush(viewController: vc)
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
    
    @objc func timeChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        
        if dateTextField.text?.isEmpty ?? false {
            self.navigationItem.rightBarButtonItem?.tintColor = .gray
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.okButton.alpha = 0.25
            self.okButton.isUserInteractionEnabled = false
            return
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 221, g: 221, b: 221)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.okButton.alpha = 1.0
            self.okButton.isUserInteractionEnabled = true
            
        }
        time = dateTextField.text
        print(time)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
