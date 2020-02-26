//
//  LTSVCTwo.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/23/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class LTSVCTwo: UICollectionViewCell {
    
    
    let customBackgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let customImageView : UIImageView = {
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(customBackgroundView)
        customBackgroundView.addSubview(customImageView)
    }
    
    
    func setupConstraints() {
        customBackgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        customBackgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        customBackgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        customBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        
    }
}
