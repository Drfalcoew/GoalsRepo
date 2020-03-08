//
//  RoutineViewSubclass.swift
//  Nightly Planner
//
//  Created by Drew Foster on 8/30/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit


class RoutineViewSubclass: UIView {
    
//    let completionLabel : UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont(name: "San Francisco", size: 15)
//        lbl.layer.masksToBounds = true
//        lbl.numberOfLines = 1
//        lbl.alpha = 1.0
//        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
//        lbl.textAlignment = .center
//        lbl.text = ""
//        lbl.lineBreakMode = .byTruncatingMiddle
//        lbl.adjustsFontSizeToFitWidth = true
//        lbl.minimumScaleFactor = 0.2
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
    
    let categoryView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return view
    }()
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 80)
        lbl.font = UIFont.boldSystemFont(ofSize: 80)
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.textAlignment = .center
        lbl.text = "Read a chapter"
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
        lbl.text = "9:30 AM"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 50)
        
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(titleLabel)
        
        self.addSubview(timeRemainingLabel)
        //self.addSubview(categoryView)
                
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
        self.backgroundColor = UIColor(r: 240, g: 240, b: 240)
    }
    
    func clear() {
        titleLabel.text = "No Routine"
        timeRemainingLabel.text = ""
    }
    
    
    func setupConstraints() {
        
        
        /*completionLabel.topAnchor.constraint(equalTo: self.subView.topAnchor, constant: 5).isActive = true
        completionLabel.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor, constant: 0).isActive = true
        completionLabel.widthAnchor.constraint(equalTo: self.subView.widthAnchor, multiplier: 0.8).isActive = true
        completionLabel.heightAnchor.constraint(equalTo: self.subView.heightAnchor, multiplier: 1/3).isActive = true
        */
        timeRemainingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        timeRemainingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        timeRemainingLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        timeRemainingLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        /*
        categoryView.bottomAnchor.constraint(equalTo: self.subView.bottomAnchor, constant: -8).isActive = true
        categoryView.centerXAnchor.constraint(equalTo: self.subView.centerXAnchor, constant: 0).isActive = true
        categoryView.widthAnchor.constraint(equalTo: self.subView.widthAnchor, multiplier: 0.8).isActive = true
        categoryView.heightAnchor.constraint(equalTo: self.subView.heightAnchor, multiplier: 1/10).isActive = true*/
                
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        
    }
    
}