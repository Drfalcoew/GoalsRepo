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
        //view.image = UIImage(named: "GreatSword")
        view.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        return view
    }()
    
    let bottomLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(r: 40, g: 43, b: 53)
        view.alpha = 0.7
        view.numberOfLines = 2
        view.font = UIFont(name: "Helvetica Neue", size: 28)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.layer.masksToBounds = true
        view.lineBreakMode = .byTruncatingTail
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let progressBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        view.layer.masksToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 40

        
        setupViews()
        setupConstraints()
    }
    
    
    func setupViews() {
        
         self.backgroundColor = UIColor(r: 221, g: 221, b: 221)
         self.categoryViewBackground.layer.cornerRadius = self.frame.height * 0.3 / 2
        
         
         self.addSubview(categoryViewBackground)
         categoryViewBackground.addSubview(goalCategoryIcon)
        
        self.addSubview(bottomLabel)
    }
    
    func setupConstraints() {
        categoryViewBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        categoryViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: self.frame.height * 0.10).isActive = true
        categoryViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30).isActive = true
        categoryViewBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30).isActive = true
        
        goalCategoryIcon.widthAnchor.constraint(equalTo: categoryViewBackground.widthAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.heightAnchor.constraint(equalTo: categoryViewBackground.heightAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.centerYAnchor.constraint(equalTo: categoryViewBackground.centerYAnchor, constant: 0).isActive = true
        goalCategoryIcon.centerXAnchor.constraint(equalTo: categoryViewBackground.centerXAnchor, constant: 0).isActive = true
        
        bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        bottomLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: categoryViewBackground.bottomAnchor, constant: 2).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
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
