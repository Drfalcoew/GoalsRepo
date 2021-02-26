//
//  WeeklyChartCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/9/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class WeeklyChartCell : UICollectionViewCell {
    
    let barView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(barView)
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 1)
        barHeightConstraint?.isActive = true
        barHeightConstraint?.constant = 1
        
        barView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        barView.leftAnchor.constraint(equalTo: centerXAnchor, constant: -8).isActive = true
        barView.rightAnchor.constraint(equalTo: centerXAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
