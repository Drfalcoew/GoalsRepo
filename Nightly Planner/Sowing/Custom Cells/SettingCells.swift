//
//  ProfileCells.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/21/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class SettingCells: UITableViewCell {
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        //label.text = "Goal Name"
        label.textColor = .black
        label.font = UIFont(name: "Palatino", size: 18)
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.textColor = UIColor(r: 120, g: 120, b: 120)
        label.textAlignment = .center
        //label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customImageView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "person")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintImageColor(color: .white)
        img.layer.masksToBounds = true
        img.isHidden = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.alpha = 0
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(customImageView)
        
        
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }
    
    
    func setupConstraints() {
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/5, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: self.frame.height + 10).isActive = true
        
        customImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        customImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        customImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        customImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
    }
    
}
