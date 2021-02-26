//
//  ProfileViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/6/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
//import GoogleMobileAds
//import Firebase

class ProfileViewController: UIViewController {
    
    var cellId = "cellId"
    var cellIdTwo = "cellIdTwo"
    var averageDays : Double = 0
    var weeklyChart : [CGFloat] = [0, 0, 0, 0, 0, 0, 0]  // Goals completed in last 7 days
    var dates : [String] = ["1/3", "1/3", "1/3", "1/3", "1/3", "1/3", "1/3"]
    var loaded : Bool? = false
    var premium : Bool? = false
    var y : Int?
    
    var myCompletedGoals: [GoalAttributes] = []
    var myCompletedTriumphs: [LongTermGoalAttributes] = []


       
       let badgeIcon : UIImageView = {
           let view = UIImageView()
           view.layer.masksToBounds = true
           view.translatesAutoresizingMaskIntoConstraints = false
           view.image = UIImage(named: "badge")
           view.isHidden = false
           return view
       }()
    
    /*let premiumLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.layer.cornerRadius = 5
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        lbl.alpha = 0
        return lbl
    }()*/
    
    var midLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 15)
        lbl.textColor = UIColor(r: 201, g: 201, b: 201)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.text = "4"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let weeklyChartView : ProfileWeeklyTrackerChart = {
        let view = ProfileWeeklyTrackerChart()
        view.backgroundColor = UIColor.clear//(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    let weeklyChartDateLabel : WeeklyChartDateLabels = {
        let view = WeeklyChartDateLabels()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let spacerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "tree_3")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.borderWidth = 3
        img.alpha = 0
        img.layer.borderColor = UIColor(r: 75, g: 80, b: 120).cgColor
        return img
    }()
    
    var weeklyChartLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "7 Day Chart"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: "Helvetica Neue", size: 21)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        //lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    var collectionView : UICollectionView!
    var triumphCollectionView : UICollectionView!
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = " "
        lbl.alpha = 0
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 35)
        lbl.font = UIFont.boldSystemFont(ofSize: 60)
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingMiddle
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        return lbl
    }()
    
    
    var Description: String?

    
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
        //weeklyChartView.chartCollectionView.reloadData()
        if y == 1 {
            badgeIcon.isHidden = true
            
        } else {
            badgeIcon.isHidden = false
        }

        //completeLabel.text = "Completed Goals: \(myCompletedGoals.count)"
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        self.view.tag = 2
        
        UserDefaults.standard.set(Description, forKey: "Description")
        UserDefaults.standard.string(forKey: "Description")  // what is this?
        
        
        if loaded != true {
            setupDatabase()
            loaded = true
        }
        setupCollectionView()
        setupVariables()
        setupViews()
        setupConstraints()
        setupNavigation()
        
    }
    
    
    func setupWeeklyChartCollectionView() {
        var weeklyDay : Int = UserDefaults.standard.integer(forKey: "weeklyDay") // starting point // 3
        let collectionViewHeight = self.view.frame.height * 0.203
        print("Weekly Day = ", weeklyDay)
        setupDates()
        var d : Int = 6
        for i in 0 ..< 7 {
            print("Line 140", weeklyChart[i])
            weeklyChartView.weeklyChart[d] = collectionViewHeight * ((weeklyChart[weeklyDay] + 0.2) / 5)
            weeklyChartDateLabel.labels[i] = self.dates[i]
            if weeklyDay > 0 {
                weeklyDay -= 1
            } else {
                // reset weeklyDay local var to 6
                weeklyDay = 6
            }
            d -= 1
        }
        weeklyChartView.chartCollectionView.reloadData()
        //weeklyChartView.values[0] = collectionViewHeight * 1
    }
    
    func setupDates() {
        var newString : String
        for i in 0 ... 6 {  // gets and sets last 7 days of the week
            newString = Date().getDay(days: -(i)).formatted
            //print("15 ", newString, newString.count)
            if newString.count > 9 {
                self.dates[i] = newString[0...4]

                
            } else if newString.count == 9 {
                self.dates[i] = newString[0...3]

                
            } else if newString.count < 9 {
                self.dates[i] = newString[0...2]

            } else {
                self.dates[i] = "Error"
                print("15 3 ",dates[i])
                
            }
        }
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
            badgeIcon.centerYAnchor.constraint(equalTo: settingsButton.topAnchor, constant: 0).isActive = true
            badgeIcon.centerXAnchor.constraint(equalTo: settingsButton.rightAnchor, constant: 0).isActive = true
            badgeIcon.widthAnchor.constraint(equalTo: settingsButton.widthAnchor, multiplier: 1).isActive = true
            badgeIcon.heightAnchor.constraint(equalTo: settingsButton.heightAnchor, multiplier: 1).isActive = true
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
    
    func setupVariables() {
        UIView.animate(withDuration: 0.5, animations: {
            self.nameLabel.alpha = 1
            self.profileImage.alpha = 1
        })
    }
    
    func setupDatabase() {
        
        
    }
    
    func setupViews() {
        self.navigationItem.title = "Profile"
        
        
        self.view.addSubview(profileImage)
        self.view.addSubview(nameLabel)
        self.view.addSubview(collectionView)
        self.view.addSubview(spacerView)
        self.view.addSubview(midLbl)
        self.view.addSubview(weeklyChartLabel)
        self.spacerView.addSubview(weeklyChartView)
        self.spacerView.addSubview(weeklyChartDateLabel)
    
        
        profileImage.layer.cornerRadius = self.view.frame.width / 4 * 0.5
        
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    
    func setupConstraints() {
        profileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 60) + self.view.frame.height * 0.1).isActive = true
        profileImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        profileImage.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        
       /* premiumLabel.widthAnchor.constraint(equalToConstant: 65.5).isActive = true
        premiumLabel.heightAnchor.constraint(equalToConstant: 33.0).isActive = true
        premiumLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 15).isActive = true
        premiumLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 0).isActive = true*/
        
        nameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/9).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: -10).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.frame.width / 10)).isActive = true
        
        spacerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24).isActive = true
        spacerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -(self.tabBarController?.tabBar.frame.height ?? 60) - 24).isActive = true
        spacerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        spacerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        
        weeklyChartView.centerXAnchor.constraint(equalTo: self.spacerView.centerXAnchor, constant: 0).isActive = true
        weeklyChartView.centerYAnchor.constraint(equalTo: self.spacerView.centerYAnchor, constant: 0).isActive = true
        weeklyChartView.widthAnchor.constraint(equalTo: self.spacerView.widthAnchor, multiplier: 0.75).isActive = true
        weeklyChartView.heightAnchor.constraint(equalTo: self.spacerView.heightAnchor, multiplier: 1/2).isActive = true
        
        midLbl.leftAnchor.constraint(equalTo: self.weeklyChartView.rightAnchor, constant: 0).isActive = true
        midLbl.centerYAnchor.constraint(equalTo: self.weeklyChartView.centerYAnchor, constant: 0).isActive = true
        midLbl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        midLbl.widthAnchor.constraint(equalToConstant: 15).isActive = true

        
        weeklyChartLabel.bottomAnchor.constraint(equalTo: self.weeklyChartView.topAnchor, constant: -4).isActive = true
        weeklyChartLabel.widthAnchor.constraint(equalTo: self.weeklyChartView.widthAnchor, multiplier: 0.5).isActive = true
        weeklyChartLabel.heightAnchor.constraint(equalTo: self.weeklyChartView.heightAnchor, multiplier: 1/4).isActive = true
        weeklyChartLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        weeklyChartDateLabel.topAnchor.constraint(equalTo: self.weeklyChartView.bottomAnchor, constant: 0).isActive = true
        weeklyChartDateLabel.widthAnchor.constraint(equalTo: self.weeklyChartView.widthAnchor, multiplier: 0.95).isActive = true
        weeklyChartDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        weeklyChartDateLabel.heightAnchor.constraint(equalTo: self.spacerView.heightAnchor, multiplier: 1/8).isActive = true
    }
    
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let completed : CGFloat
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileStatsCollectionViewCell


        switch indexPath.row {
        case 0:
            cell.bottomLabel.text = "Tasks completed"
            cell.centerLabel.text = "\(myCompletedGoals.count)"
            return cell
        case 1:
            cell.bottomLabel.text = "Average days to complete"
            averageDays = 0
            if myCompletedGoals.count > 0 {
                for i in 0..<myCompletedGoals.count {
                    averageDays = averageDays + Double(myCompletedGoals[i].daysTaken!)
                }
                averageDays = averageDays / Double(myCompletedGoals.count)
                averageDays = Double(round(10*averageDays)/10)
                cell.centerLabel.text = "\(averageDays)"
               /* if averageDays >= 3 {
                    cell.centerLabel.textColor = UIColor(r: 230, g: 81, b: 87)
                } else {
                    cell.centerLabel.textColor = UIColor(r: 125, g: 200, b: 180)
                } */
            } else {
                cell.centerLabel.text = ""
            }
            return cell
        case 2:
            cell.bottomLabel.text = "Goals Completed"
            cell.centerLabel.text = "\(myCompletedTriumphs.count)"
        default: break
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5, animations: {
                cell.alpha = 1
            })
        }
        
        return cell
   
    }
    
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 4), height: ((self.view.frame.width / 4)))
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor.clear//(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.isPagingEnabled = true
        collectionView.layer.zPosition = 2
        
        collectionView.register(ProfileStatsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
}
