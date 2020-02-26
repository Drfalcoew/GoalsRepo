//
//  RoutineViewSubclass.swift
//  Nightly Planner
//
//  Created by Drew Foster on 8/30/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit


class RoutineViewSubclass: UIView {
    
    let completionLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "San Francisco", size: 15)
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.alpha = 1.0
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.textAlignment = .center
        lbl.text = ""
        lbl.lineBreakMode = .byTruncatingMiddle
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 44, g: 53, b: 70)
        return view
    }()
    
    let categoryView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return view
    }()
    
    let titleLabelView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(r: 44, g: 53, b: 70)
        return view
    }()
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 80)
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.textAlignment = .center
        lbl.text = ""
        lbl.lineBreakMode = .byTruncatingTail
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let timeRemainingLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = ""
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 221, g: 221, b: 221)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    let nonPremiumCover : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(nonPremiumCover)
        self.addSubview(titleLabelView)
        self.titleLabelView.addSubview(titleLabel)
        
        self.addSubview(subView)
        
        subView.addSubview(timeRemainingLabel)
        subView.addSubview(completionLabel)
        subView.addSubview(categoryView)
                
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
        
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.clear//(white: 1.0, alpha: 1.0)
    }
    
    func clear() {
        completionLabel.text = ""
        titleLabel.text = "No Routine"
        timeRemainingLabel.text = ""
        
    }
    
    
    func setupConstraints() {
        
        self.nonPremiumCover.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        self.nonPremiumCover.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.nonPremiumCover.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nonPremiumCover.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        subView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        subView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        subView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5.5).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        completionLabel.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 5).isActive = true
        completionLabel.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor, constant: 0).isActive = true
        completionLabel.widthAnchor.constraint(equalTo: self.subView.widthAnchor, multiplier: 0.8).isActive = true
        completionLabel.heightAnchor.constraint(equalTo: self.subView.heightAnchor, multiplier: 1/3).isActive = true
        
        timeRemainingLabel.centerYAnchor.constraint(equalTo: self.subView.centerYAnchor, constant: 0).isActive = true
        timeRemainingLabel.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor, constant: 0).isActive = true
        timeRemainingLabel.widthAnchor.constraint(equalTo: self.subView.widthAnchor, multiplier: 0.8).isActive = true
        timeRemainingLabel.heightAnchor.constraint(equalTo: self.subView.heightAnchor, multiplier: 1/3).isActive = true
        
        categoryView.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: -8).isActive = true
        categoryView.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor, constant: 0).isActive = true
        categoryView.widthAnchor.constraint(equalTo: self.subView.widthAnchor, multiplier: 0.8).isActive = true
        categoryView.heightAnchor.constraint(equalTo: self.subView.heightAnchor, multiplier: 1/10).isActive = true
        
        titleLabelView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        titleLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleLabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        titleLabelView.rightAnchor.constraint(equalTo: self.categoryView.leftAnchor, constant: -10).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.titleLabelView.leftAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.titleLabelView.topAnchor, constant: 5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.titleLabelView.bottomAnchor, constant: -5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.titleLabelView.rightAnchor, constant: -5).isActive = true
        
        
    }
    
}
