//
//  LongTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/18/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class LongTermCell: UICollectionViewCell {
    
    var x : CGFloat?
    

    let longTermLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = " "
        lbl.layer.masksToBounds = true
        //lbl.numberOfLines = 1
        //lbl.lineBreakMode = .byTruncatingMiddle
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.font = UIFont.boldSystemFont(ofSize: 35)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let goalCategoryIcon : UIImageView = {
        let view = UIImageView()
        //view.tintImageColor(color: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(5)
        view.layer.borderColor = UIColor(r: 242, g: 182, b: 255).cgColor
        view.backgroundColor = UIColor.clear//(r: 163, g: 171, b: 199)
        return view
    }()
    
    let progressBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        view.layer.masksToBounds = true
        view.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
        
        setupViews()
    }
    
    
    func setupViews() {
        
        self.layer.cornerRadius = 2
        //self.backgroundColor = UIColor(r: 211, g: 211, b: 211)
        self.categoryViewBackground.layer.cornerRadius = self.frame.height * 0.80 / 2
        categoryViewBackground.layer.zPosition = 1
        goalCategoryIcon.layer.zPosition = 2
        
        //self.addSubview(progressBackgroundView)
        
        self.addSubview(categoryViewBackground)
        self.addSubview(goalCategoryIcon)
        self.addSubview(longTermLabel)
        
        //progressBackgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (x ?? 0) * 100)
        
        categoryViewBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        categoryViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        categoryViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80).isActive = true
        categoryViewBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.80).isActive = true
        
        goalCategoryIcon.bottomAnchor.constraint(equalTo: self.categoryViewBackground.bottomAnchor, constant: self.frame.height * -0.05).isActive = true
        goalCategoryIcon.widthAnchor.constraint(equalTo: categoryViewBackground.widthAnchor, multiplier: 1.1).isActive = true
        goalCategoryIcon.heightAnchor.constraint(equalTo: categoryViewBackground.heightAnchor, multiplier: 1.1).isActive = true
        goalCategoryIcon.centerXAnchor.constraint(equalTo: categoryViewBackground.centerXAnchor, constant: 0).isActive = true
        
        //self.backgroundColor = .lightGray
        //longTermLabel.backgroundColor = .darkGray
        longTermLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        longTermLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        longTermLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        longTermLabel.topAnchor.constraint(equalTo: self.categoryViewBackground.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
