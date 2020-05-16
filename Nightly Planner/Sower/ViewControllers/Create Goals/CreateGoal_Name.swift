//
//  CreateGoal_Name.swift
//  Sower
//
//  Created by Drew Foster on 3/10/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CreateGoal_Name: UIViewController {
    
    var goalType : Int?
    
    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.titleLabel.text = "Enter Goal Name"
        view.subLabel_0.text = "Ask yourself - \"What do I want?\""
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
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
    var goalName : UITextField = {
        let text = UITextField()
        text.backgroundColor = UIColor.clear//(r: 75, g: 80, b: 120)
        text.textColor = UIColor(r: 75, g: 80, b: 120)
        text.layer.masksToBounds = true
        text.placeholder = "Enter Goal Name"
        text.textAlignment = .center
        text.font = UIFont(name: "Helvetica Neue", size: 35)
        text.layer.cornerRadius = 5
        text.layer.borderColor = UIColor.gray.cgColor
        text.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        self.title = "Goal Name"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateShortTerm_0.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        
        goalName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        goalName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2.5/3).isActive = true
        goalName.heightAnchor.constraint(equalTo: self.goalName.widthAnchor, multiplier: 3/5).isActive = true
        goalName.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 8).isActive = true
        
        
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
    
    func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
        goalName.inputAccessoryView = toolbar
    }
    
    func setupViews() {
        self.view.addSubview(greetingView)
        self.view.addSubview(goalName)
        self.view.addSubview(okButton)
    }
    
    
    @objc func handleAddGoal() {
        if goalName.text?.isEmpty != true {
            let vc = CreateGoal_TargetDate()
            vc.goalText = goalName.text!
            vc.goalType = self.goalType
            self.navigationController?.customPush(viewController: vc)
        }
    }
    
    @objc func textDidChange(_ textField : UITextField) {
        if goalName.text?.isEmpty ?? false {
            self.navigationItem.rightBarButtonItem?.tintColor = .gray
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.okButton.alpha = 0.25
            self.okButton.isUserInteractionEnabled = false
            return
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 75, g: 80, b: 120)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.okButton.alpha = 1.0
            self.okButton.isUserInteractionEnabled = true

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
