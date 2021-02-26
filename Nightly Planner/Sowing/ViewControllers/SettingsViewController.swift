//
//  MenuViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/8/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit
//import Firebase
//import GoogleMobileAds

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    var y : Int?
    let notification = NotificationCenter.default

    
    
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let badgeIcon : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "badge")
        view.isHidden = false
        return view
    }()
    
    var date : UILabel = {
        let lbl = UILabel()
        lbl.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        interstitialAd()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = date.text
        self.view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        
        y = UserDefaults.standard.integer(forKey: "Notifications")
        
        setupTableView()
        setupViews()
        setupConstraints()
    }
    
    func interstitialAd() {
        var adCount = UserDefaults.standard.integer(forKey: "ad")
        adCount = adCount + 1
        UserDefaults.standard.set(adCount, forKey: "ad")
        UserDefaults.standard.synchronize()
        print(adCount)
        
        if adCount % 10 == 0 { // every 5 page turns, open an ad
            //show ad
            //showAd()
        }
    }
    

    
    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor(r: 221, g: 221, b: 221)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 221, g: 221, b: 221)]
    }
    
    func setupConstraints() {
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
    
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCells.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        tableView.separatorColor = .black
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! SettingCells
        if indexPath.row == 0 {
            cell.nameLabel.textColor = UIColor(r: 125, g: 200, b: 180)
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "HEROISM"
            break
        case 1:
            cell.nameLabel.text = "Learn More"
            break
        case 2:
            cell.nameLabel.text = "Setup Notifications"
            if y != 1 {
                cell.contentView.addSubview(badgeIcon)
                badgeIcon.isHidden = false
                badgeIcon.centerXAnchor.constraint(equalTo: cell.nameLabel.rightAnchor, constant: 0).isActive = true
                badgeIcon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: -10).isActive = true
                badgeIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
                badgeIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
            }
            break
        case 3:
            cell.nameLabel.text = "Feedback"
            break
        case 4:
            cell.nameLabel.text = "Logout"
            break
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED ROW \(indexPath.row)")
        switch indexPath.row {
        case 0:
            //navigationController?.customPush(viewController: PremiumViewController())
            break
        case 1:
            navigationController?.customPush(viewController: LearnMoreViewController())
            break
        case 2:
            //navigationController?.customPush(viewController: RequestNotifications())
            break
        case 3:
            navigationController?.customPush(viewController: FeedbackViewController())
        case 4:
            notification.post(name: Notification.Name("StopMusic"), object: nil)
            //navigationController?.customPush(viewController: LoginController())
            break
        default:
            functionUnavailable()
            break
        }
    }
    
    
    func functionUnavailable() {
        
        //post notification here

        
        
        let myAlert = UIAlertController(title: "Function Unavailable", message: "Please check back in the future.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
}
