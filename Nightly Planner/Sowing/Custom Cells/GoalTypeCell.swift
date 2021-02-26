//
//  InspirationCollectionViewCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 5/23/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class GoalTypeCell: UICollectionViewCell {
        
    let goalCategoryIcon : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let displayLabel : UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.textColor = UIColor(r: 180, g: 180, b: 180)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        self.backgroundColor = .white
        self.layer.borderWidth = CGFloat(2)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = self.frame.width / 2
        
        
        self.addSubview(goalCategoryIcon)
        goalCategoryIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goalCategoryIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        goalCategoryIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95).isActive = true
        goalCategoryIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.layer.borderColor = UIColor.darkGray.cgColor
                self.layer.borderWidth = CGFloat(4)
            }
            else {
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.borderWidth = CGFloat(2)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

