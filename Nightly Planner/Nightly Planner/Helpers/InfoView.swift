//
//  InfoView.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/30/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    let infoImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "info")
        img.layer.cornerRadius = 10
        return img
    }()
    
    let infoLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "San Francisco", size: 30)
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(infoLabel)
        self.addSubview(infoImageView)
        
        addBehavior()
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior() {
        print("Add all the behavior here")
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
    }
    
    
    func setupConstraints() {
        infoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        infoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        infoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
        infoImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
        
        infoLabel.leftAnchor.constraint(equalTo: infoImageView.rightAnchor, constant: 8).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
    }
    
}
