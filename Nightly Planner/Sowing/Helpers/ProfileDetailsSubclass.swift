//
//  ProfileDetailsSubclass.swift
//  Sowing
//
//  Created by Drew Foster on 6/30/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetaisSubclass: UIView {
    
    let titles : [String] = ["", "Apprentice", "Gardener", "Sharecropper", "Farmer", "Greenthumb", "Master Sower", "Grand Master Sower"]
    let levels : [Int] = [0, 3, 5, 10, 20, 39, 74, 141]

    var goals : Int = UserDefaults.standard.integer(forKey: "completedGoals")
    var totalGoals : Int? = UserDefaults.standard.integer(forKey: "totalGoals")
    
    let profileImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "tree_3")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.borderWidth = 0
        img.alpha = 0
        return img
    }()
    
    let profileButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(handleEditProfileImg), for: .touchUpInside)
        btn.layer.borderWidth = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        return btn
    }()
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Username"
        lbl.alpha = 0
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 35)
        lbl.font = UIFont.boldSystemFont(ofSize: 55)
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingMiddle
        lbl.textColor = .darkGray
        return lbl
    }()
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.text = "Title"
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.textColor = .gray
        return lbl
    }()

    
    override func layoutSubviews() {
        profileImage.layer.cornerRadius = self.frame.width / 3 * 0.5
        profileButton.layer.cornerRadius = self.frame.width / 3 * 0.5

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        setupViews()
        setupConstraints()
        setupVariables()
    }
    
    @objc func setupVariables() {
        
        nameLabel.text = UserDefaults.standard.string(forKey: "Username") ?? "Username"
        if nameLabel.text == nil {
            nameLabel.text = "Username"
        }
        
        var _index : Int = 0
        if let _temp = levels.firstIndex(where: { $0 == totalGoals }) {
            if _temp > 0 {
                _index = _temp - 1
            } else { _index = _temp }
        }
        
        titleLabel.text = titles[_index]
        
        UIView.animate(withDuration: 0.5, animations: {
            self.nameLabel.alpha = 1
            self.profileImage.alpha = 1
        })
    }
    
    func setupViews() {
        self.addSubview(profileButton)
        self.profileButton.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            profileButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            profileButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            
            profileImage.centerXAnchor.constraint(equalTo: self.profileButton.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: self.profileButton.centerYAnchor),
            profileImage.widthAnchor.constraint(equalTo: self.profileButton.widthAnchor, multiplier: 1),
            profileImage.heightAnchor.constraint(equalTo: self.profileButton.widthAnchor, multiplier: 1),
    
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2.2),
            nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: self.profileButton.bottomAnchor, constant: 0),
            
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalTo: self.titleLabel.widthAnchor, multiplier: 1/3)
            
        ])
        
    }
    
    @objc func handleEditProfileImg() {
        print("Testing")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EditProfileImageView"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}




class ProfileStatsSubclass : UIView {
    
    let timeValue: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.text = "0"
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        return lbl
    }()
    
    let goalValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.text = "0"
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    let timeVariable : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "averageTime")?.withRenderingMode(.alwaysTemplate)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.tintImageColor(color: UIColor.darkGray)
        return img
    }()
    
    let goalVariable : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.text = "Completed"
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.textColor = .darkGray
        return lbl
    }()
    
    override func layoutSubviews() {
        timeVariable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * 0.2).isActive = true
        goalVariable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: (self.frame.width * -0.2)).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVariables()
        setupViews()
        setupConstraints()
    }
    
    func setupVariables() {
        //timeValue =
        //goalValue =
    }
    
    
    func setupViews() {
        self.addSubview(timeValue)
        self.addSubview(goalValue)
        self.addSubview(timeVariable)
        self.addSubview(goalVariable)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timeVariable.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            timeVariable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6),
            timeVariable.heightAnchor.constraint(equalTo: self.timeVariable.widthAnchor, multiplier: 0.45),
            
            goalVariable.centerYAnchor.constraint(equalTo: self.timeVariable.centerYAnchor, constant: 0),
            goalVariable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            goalVariable.heightAnchor.constraint(equalTo: self.timeVariable.widthAnchor, multiplier: 0.6),
            
            
            goalValue.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            goalValue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            goalValue.heightAnchor.constraint(equalTo: self.goalVariable.widthAnchor, multiplier: 1/3),
            goalValue.centerXAnchor.constraint(equalTo: self.goalVariable.centerXAnchor),
            
            timeValue.centerYAnchor.constraint(equalTo: self.goalValue.centerYAnchor, constant: 0),
            timeValue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            timeValue.heightAnchor.constraint(equalTo: self.timeVariable.widthAnchor, multiplier: 1/3),
            timeValue.centerXAnchor.constraint(equalTo: self.timeVariable.centerXAnchor),
        ])
        
    }
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
