//
//  ProfileStatsCollectionViewCells.swift
//  Nightly Planner
//
//  Created by Drew Foster on 5/26/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class ProfileStatsCollectionViewCell: UICollectionViewCell {
    
    
    var x : CGFloat?
    
    let centerLabel : UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.textColor = UIColor(r: 40, g: 43, b: 53)
        view.font = UIFont(name: "Helvetica Neue", size: 40)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bottomLabel : UILabel = {
        let view = UILabel()
        view.textColor = UIColor(r: 125, g: 200, b: 180)
        view.alpha = 0.8
        view.numberOfLines = 2
        view.font = UIFont(name: "Helvetica Neue", size: 30)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.1
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    
    func setupViews() {
        self.addSubview(centerLabel)
        self.addSubview(bottomLabel)
        
        centerLabel.layer.cornerRadius = self.frame.width * 0.70 / 2
    }
    
    func setupConstraints() {
        centerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        centerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        centerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70).isActive = true
        centerLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.70).isActive = true
        
        
        bottomLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        bottomLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 2).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
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
