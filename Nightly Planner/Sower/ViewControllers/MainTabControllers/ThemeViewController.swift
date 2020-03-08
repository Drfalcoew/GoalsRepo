//
//  ThemeViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/1/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ThemeViewController: UIViewController {
    
    
    let dayView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        return view
    }()
    
    let nightView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let dayImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "2")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    let nightImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "night")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigation()
        setupConstraints()
    }
    
    func setupViews() {
        
        self.view.addSubview(nightView)
        self.view.addSubview(dayView)
        
        nightView.addSubview(nightImage)
        dayView.addSubview(dayImage)
    }
    
    func setupConstraints() {
        nightView.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        nightView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        nightView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        nightView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        
        dayView.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        dayView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        dayView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        dayView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        
        nightImage.centerXAnchor.constraint(equalTo: self.nightView.centerXAnchor, constant: 0).isActive = true
        nightImage.centerYAnchor.constraint(equalTo: self.nightView.centerYAnchor, constant: 0).isActive = true
        nightImage.heightAnchor.constraint(equalTo: self.nightView.heightAnchor, multiplier: 1/10).isActive = true
        nightImage.widthAnchor.constraint(equalTo: self.nightView.heightAnchor, multiplier: 1/10).isActive = true
        
        dayImage.centerXAnchor.constraint(equalTo: self.dayView.centerXAnchor, constant: 0).isActive = true
        dayImage.centerYAnchor.constraint(equalTo: self.dayView.centerYAnchor, constant: 0).isActive = true
        dayImage.heightAnchor.constraint(equalTo: self.dayView.heightAnchor, multiplier: 1/10).isActive = true
        dayImage.widthAnchor.constraint(equalTo: self.dayView.heightAnchor, multiplier: 1/10).isActive = true
    }
    
    func setupNavigation() {
        self.title = "Theme"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 221, g: 221, b: 221)]

        let mainIcon = UIButton(type: .system)
        mainIcon.setImage(UIImage(named: "mainIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        mainIcon.isUserInteractionEnabled = false
        mainIcon.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        if #available(iOS 9.0, *) {
            mainIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
            mainIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        }
        mainIcon.contentMode = .scaleAspectFit
        //nightBtn
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainIcon)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
