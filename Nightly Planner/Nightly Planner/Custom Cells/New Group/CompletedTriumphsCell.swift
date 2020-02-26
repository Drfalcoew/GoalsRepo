//
//  CompletedTriumphsCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/15/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class CompletedTriumphsCell: UICollectionViewCell {
    
    
    var x : CGFloat?
    
    let goalCategoryIcon : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let progressBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        view.layer.masksToBounds = true
        view.layer.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    func setupViews() {
        /*
        //self.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        
        self.categoryViewBackground.layer.cornerRadius = self.frame.height * 0.5 / 2
        
        
        //self.addSubview(progressBackgroundView)
        self.addSubview(categoryViewBackground)
        categoryViewBackground.addSubview(goalCategoryIcon)
        
        //progressBackgroundView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (x ?? 0) * 100)
        
        categoryViewBackground.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        categoryViewBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        categoryViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
        categoryViewBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.50).isActive = true
        
        goalCategoryIcon.widthAnchor.constraint(equalTo: categoryViewBackground.widthAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.heightAnchor.constraint(equalTo: categoryViewBackground.heightAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.centerYAnchor.constraint(equalTo: categoryViewBackground.centerYAnchor, constant: 0).isActive = true
        goalCategoryIcon.centerXAnchor.constraint(equalTo: categoryViewBackground.centerXAnchor, constant: 0).isActive = true
        
        */
        
    }
    
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                //self.goalCategoryIcon.tintImageColor(color: UIColor(r: 125, g: 200, b: 180))
                
            }
            else {
                //self.goalCategoryIcon.tintImageColor(color: .white)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
}
