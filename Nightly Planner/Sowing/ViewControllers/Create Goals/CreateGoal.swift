//
//  CreateGoal.swift
//  Nightly Planner
//
//  Created by Drew Foster on 8/13/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//


import Foundation
import UIKit

class CreateGoal: UIViewController {

    var goalType : Int?
    
    let greetingView : GreetingViewSubclass = {
        let view = GreetingViewSubclass()
        view.titleLabel.text = "Create a Goal"
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
        btn.alpha = 0.5
        btn.isUserInteractionEnabled = false
        btn.setTitleColor(UIColor(r: 240, g: 240, b: 240), for: .normal)
        btn.addTarget(self, action: #selector(nextGoal), for: .touchUpInside)
        return btn
    }()
    
    var addGoalButton: UIButton = {
           let button = UIButton(type: .system)
           button.backgroundColor = UIColor(red: 75/255, green: 80/255, blue: 120/255, alpha: 1.0)
           button.setTitle("Next", for: UIControl.State())
           button.translatesAutoresizingMaskIntoConstraints = false
           button.layer.cornerRadius = 5
           button.setTitleColor(UIColor(r: 240, g: 240, b: 240), for: UIControl.State())
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
           button.isHidden = true
           button.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
           return button
       }()
    
    var taskBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = CGFloat(2)
        btn.alpha = 0.5
        btn.tag = 0
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.backgroundColor = UIColor.clear//(r: 40, g: 43, b: 53)
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
    var taskImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "task")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
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
        btn.addTarget(self, action: #selector(handleAddGoal), for: .touchUpInside)
        return btn
    }()
    
    var routineImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "routine")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    
    let routineLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Routine"
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.alpha = 0.25
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        return lbl
    }()
    
    let taskLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "One-time"
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.alpha = 0.25
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        return lbl
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
        //self.title = "Goal Type"
        
        print("VIEW DID LOAD")
        
        
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigation() {
        var done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(nextGoal))
        done.tintColor = .gray
        done.isEnabled = false
        self.navigationItem.rightBarButtonItem = done
    }
    
    func setupConstraints() {
        
        greetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        greetingView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8).isActive = true
        greetingView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.93).isActive = true
        greetingView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.035).isActive = true
        
        
        taskBtn.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 6).isActive = true
        taskBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width / 6).isActive = true
        taskBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        taskBtn.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        
        taskImg.centerXAnchor.constraint(equalTo: self.taskBtn.centerXAnchor, constant: 0).isActive = true
        taskImg.centerYAnchor.constraint(equalTo: self.taskBtn.centerYAnchor, constant: 0).isActive = true
        taskImg.widthAnchor.constraint(equalTo: self.taskBtn.widthAnchor, multiplier: 0.7).isActive = true
        taskImg.heightAnchor.constraint(equalTo: self.taskBtn.heightAnchor, multiplier: 0.7).isActive = true
        
        taskLbl.bottomAnchor.constraint(equalTo: self.taskBtn.topAnchor, constant: -10).isActive = true
        taskLbl.centerXAnchor.constraint(equalTo: self.taskBtn.centerXAnchor, constant: 0).isActive = true
        taskLbl.widthAnchor.constraint(equalTo: self.taskBtn.widthAnchor, multiplier: 1.35).isActive = true
        taskLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        routineBtn.topAnchor.constraint(equalTo: self.greetingView.bottomAnchor, constant: self.view.frame.height / 6).isActive = true
        routineBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: self.view.frame.width / -6).isActive = true
        routineBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        routineBtn.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5).isActive = true
        
        routineImg.centerXAnchor.constraint(equalTo: self.routineBtn.centerXAnchor, constant: 0).isActive = true
        routineImg.centerYAnchor.constraint(equalTo: self.routineBtn.centerYAnchor, constant: 0).isActive = true
        routineImg.widthAnchor.constraint(equalTo: self.routineBtn.widthAnchor, multiplier: 0.7).isActive = true
        routineImg.heightAnchor.constraint(equalTo: self.routineBtn.heightAnchor, multiplier: 0.7).isActive = true
        
        routineLbl.bottomAnchor.constraint(equalTo: self.routineBtn.topAnchor, constant: -10).isActive = true
        routineLbl.centerXAnchor.constraint(equalTo: self.routineBtn.centerXAnchor, constant: 0).isActive = true
        routineLbl.widthAnchor.constraint(equalTo: self.routineBtn.widthAnchor, multiplier: 1).isActive = true
        routineLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addGoalButton.topAnchor.constraint(equalTo: self.routineBtn.bottomAnchor, constant: 30).isActive = true
        addGoalButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2.2/3).isActive = true
        addGoalButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ((1/4.5)/3)/1.5).isActive = true
        
        okButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        okButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0).isActive = true
        okButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        }
   
    
    func setupViews() {
        taskBtn.layer.cornerRadius = self.view.frame.width / 9
        routineBtn.layer.cornerRadius = self.view.frame.width / 9
        
        
        self.view.addSubview(greetingView)
        self.view.addSubview(taskBtn)
        self.view.addSubview(routineBtn)
        self.view.addSubview(okButton)
        
        self.routineBtn.addSubview(routineImg)
        self.taskBtn.addSubview(taskImg)
        self.view.addSubview(routineLbl)
        self.view.addSubview(taskLbl)
        self.view.addSubview(addGoalButton)
    }
    
    @objc func nextGoal() {
        print("IN NEXT GOAL")
        if goalType == 0 || goalType == 1 {
            let vc = CreateShortTerm_0()
            vc.goalType = self.goalType
            self.navigationController?.customPush(viewController: vc)
        } else {
            /*
            let vc = CreateGoal_Name()
            vc.goalType = 2
            self.navigationController?.customPush(viewController: vc)
 */
        }
    }
    
    
    @objc func handleAddGoal(sender: UIButton) {
        if sender.tag == 1 {
            goalType = 1
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.okButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.35) {
                self.routineBtn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
                self.routineLbl.alpha = 1.0
                self.routineBtn.alpha = 1.0
                
                self.taskBtn.backgroundColor = UIColor.clear
                self.taskLbl.alpha = 0.5
                self.taskBtn.alpha = 0.5
                
                self.okButton.alpha = 1.0
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 75, g: 80, b: 120)
            }
        } else if sender.tag == 0 {
            self.okButton.isUserInteractionEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            goalType = 0
            UIView.animate(withDuration: 0.35) {
                self.taskBtn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
                self.taskBtn.alpha = 1.0
                self.taskLbl.alpha = 1.0
                
                self.routineBtn.backgroundColor = UIColor.clear
                self.routineLbl.alpha = 0.5
                self.routineBtn.alpha = 0.5
                
                self.okButton.alpha = 1.0
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 75, g: 80, b: 120)
            }
        } else {
            
            self.okButton.isUserInteractionEnabled = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.goalType = 2
            UIView.animate(withDuration: 0.35) {

                self.routineBtn.backgroundColor = UIColor.clear
                self.routineLbl.alpha = 0.5
                self.routineBtn.alpha = 0.5
                self.taskLbl.alpha = 0.5
                self.taskBtn.backgroundColor = .clear
                self.taskBtn.alpha = 0.5
                
                self.okButton.alpha = 1.0
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 75, g: 80, b: 120)
            }
        }
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
