//
//  GreetingViewSubclass.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/4/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit



class GreetingViewSubclass: UIView {
 
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "San Francisco", size: 30)
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingTail
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let subLabel_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.alpha = 0.5
        lbl.text = ""
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    let subLabelImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.backgroundColor = .clear
        img.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        img.alpha = 0.5
        return img
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(subLabel_0)
        self.addSubview(subLabelImage)
        self.addSubview(titleLabel)
        
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
        
        self.layer.cornerRadius = 5
    }
    
    
    func setupConstraints() {
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.9/2).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        
        subLabel_0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        subLabel_0.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        subLabel_0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
        subLabel_0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        subLabelImage.leftAnchor.constraint(equalTo: self.subLabel_0.rightAnchor, constant: 10).isActive = true
        subLabelImage.centerYAnchor.constraint(equalTo: self.subLabel_0.centerYAnchor, constant: 0).isActive = true
        subLabelImage.widthAnchor.constraint(equalTo: subLabel_0.heightAnchor, multiplier: 1).isActive = true
        subLabelImage.heightAnchor.constraint(equalTo: subLabel_0.heightAnchor, multiplier: 1).isActive = true
        
    }
}
