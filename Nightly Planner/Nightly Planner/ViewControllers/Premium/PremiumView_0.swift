//
//  PremiumView_0.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class PremiumView_0: UICollectionViewCell {
    
    let routineView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.zPosition = 0
        view.layer.cornerRadius = 15
        view.image = UIImage(named: "routineImage")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(routineView)
    }
    
    func setupConstraints() {
        routineView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        routineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        routineView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        routineView.heightAnchor.constraint(equalTo: self.routineView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
