//
//  LongTermStatsSubclass.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/1/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class LongTermStatsSubclass: UIView {
    
    var label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.text = ""
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.isHidden = false
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var value : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.isHidden = false
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addBehavior()
        addViews()
        setupConstraints()
    }
    
    func addViews() {
        self.addSubview(label)
        self.addSubview(value)
    }
  
   /* convenience init() {
        self.init(frame: CGRect.zero)
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior() {
        
        self.layer.cornerRadius = 5

    }

    
    func setupConstraints() {
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        label.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        value.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        value.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.87).isActive = true
        value.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        value.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
    }
}
