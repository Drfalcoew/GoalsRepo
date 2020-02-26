//
//  imageCollectionViewCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/27/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class imageCollectionViewCell: UICollectionViewCell {
    
    let goalCategoryIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
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
        goalCategoryIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(r: 125, g: 200, b: 180)
            }
            else {
                self.backgroundColor = .white
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

