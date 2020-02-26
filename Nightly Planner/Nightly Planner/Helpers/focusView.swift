//
//  focusView.swift
//  Nightly Planner
//
//  Created by Drew Foster on 5/12/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class FocusView: UIView {
    
    let focusImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "")
        //img.layer.cornerRadius = 10
        return img
    }()
    
    let focusLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 45)
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(focusLabel)
        self.addSubview(focusImageView)
        
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
        focusImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        focusImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        focusImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.125).isActive = true
        focusImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.125).isActive = true
        
        focusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        focusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        focusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        focusLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
}
