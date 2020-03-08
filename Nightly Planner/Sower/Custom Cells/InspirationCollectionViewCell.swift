//
//  InspirationCollectionViewCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 5/23/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class InspirationCollectionViewCell: UICollectionViewCell {
    
    /*let goalCategoryIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()*/
    
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
        
        
        self.addSubview(displayLabel)
        displayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        displayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        displayLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95).isActive = true
        displayLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
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

