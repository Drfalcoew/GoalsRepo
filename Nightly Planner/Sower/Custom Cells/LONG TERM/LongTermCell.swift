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

    let view : LongTermCellSubclassView = {
        let view = LongTermCellSubclassView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(view)
        
        
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
