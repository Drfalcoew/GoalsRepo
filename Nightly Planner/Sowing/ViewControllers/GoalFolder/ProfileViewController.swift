//
//  ProfileViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/6/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var y : Int?
    
    let badgeIcon : UIImageView = {
       let view = UIImageView()
       view.layer.masksToBounds = true
       view.translatesAutoresizingMaskIntoConstraints = false
       view.image = UIImage(named: "badge")
       view.isHidden = false
       return view
    }()
    
    
    let reflectionView : ReflectionSubclass = {
        let view = ReflectionSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileView : ProfileDetaisSubclass = {
        let view = ProfileDetaisSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileStatsView : ProfileStatsSubclass = {
        let view = ProfileStatsSubclass()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collabView : CollaborationsSubclass = {
        let view = CollaborationsSubclass()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLayoutSubviews() {        
//        self.goodButton.layer.cornerRadius = self.view.frame.width * 0.075
//        self.badButton.layer.cornerRadius = self.view.frame.width * 0.075
    }
        
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
        if y == 1 {
            badgeIcon.isHidden = true
            
        } else {
            badgeIcon.isHidden = false
        }

        //completeLabel.text = "Completed Goals: \(myCompletedGoals.count)"
        self.tabBarController?.tabBar.isHidden = false
    }
    
  
    override func viewDidLoad() {
        self.view.tag = 2
        
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(editProfileImage), name: Notification.Name("EditProfileImageView"), object: nil)
        nc.addObserver(self, selector: #selector(setupVariables), name: Notification.Name("setupVariables"), object: nil)
        nc.addObserver(self, selector: #selector(handleChartTap), name: Notification.Name("handleChartTap"), object: nil)

        
        setupVariables()
        setupViews()
        setupConstraints()
        setupNavigation()
        
    }
    
    @objc func setupVariables() {
        print(UserDefaults.standard.integer(forKey: "totalDaysTaken"))
        
        if UserDefaults.standard.integer(forKey: "totalOneTimeGoals") != 0 {
            let x : Double = Double(UserDefaults.standard.integer(forKey: "totalDaysTaken") / UserDefaults.standard.integer(forKey: "totalOneTimeGoals"))
            profileStatsView.timeValue.text = "\(x)"
        } else { profileStatsView.timeValue.text = "0" }
        
        profileView.nameLabel.text = UserDefaults.standard.string(forKey: "Username")
        profileStatsView.goalValue.text = "\(UserDefaults.standard.integer(forKey: "completedGoals"))"
    }
    
    @objc func editProfileImage() {
        self.navigationController?.customPush(viewController: EditProfileImageView())
    }
    
    @objc func handleChartTap() {
        self.navigationController?.customPush(viewController: LifeView())
    }
    
    func setupNavigation() {
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        
        self.title = "Profile"
        
        //navigationController?.navigationBar.tintColor = UIColor(r: 221, g: 221, b: 221)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
        
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
            NSLayoutConstraint.activate([
                badgeIcon.centerYAnchor.constraint(equalTo: settingsButton.topAnchor, constant: 0),
                badgeIcon.centerXAnchor.constraint(equalTo: settingsButton.rightAnchor, constant: 0),
                badgeIcon.widthAnchor.constraint(equalTo: settingsButton.widthAnchor, multiplier: 1),
                badgeIcon.heightAnchor.constraint(equalTo: settingsButton.heightAnchor, multiplier: 1)                
            ])
            badgeIcon.isHidden = false
        }
        
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)

        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)        
    }
    
    @objc func Settings() {
        navigationController?.customPush(viewController: SettingsViewController())
    }
    
    lazy var showMenu : ShowMenu = {
        let showMenu = ShowMenu()
        showMenu.viewController = self
        return showMenu
    }()
    
    @objc func showSettings() {
        showMenu.Settings()
    }
    
   

    func setupViews() {
        self.navigationItem.title = "Profile"
                
        self.view.addSubview(profileView)
        self.view.addSubview(reflectionView)
        self.view.addSubview(profileStatsView)
        self.view.addSubview(collabView)
        
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([                        

            profileView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.05),
            profileView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3),
            profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                        
            profileStatsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileStatsView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            profileStatsView.topAnchor.constraint(equalTo: self.profileView.bottomAnchor, constant: -10),
            profileStatsView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6),
            
            reflectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            reflectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4.5),
            reflectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            reflectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4.3),
            
            collabView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            collabView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            collabView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3),
            collabView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3)
        
        ])
    }
}
