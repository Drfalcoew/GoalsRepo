//
//  ProfileChartCells.swift
//  Sowing
//
//  Created by Drew Foster on 2/27/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import UIKit

class ProfileChartCell: UICollectionViewCell {
    
    let bgView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        self.addSubview(bgView)
        self.bgView.addSubview(image)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        bgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        image.centerXAnchor.constraint(equalTo: self.bgView.centerXAnchor, constant: 0).isActive = true
        image.widthAnchor.constraint(equalTo: self.bgView.widthAnchor, multiplier: 0.8).isActive = true
        image.heightAnchor.constraint(equalTo: self.bgView.widthAnchor, multiplier: 0.8).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bgView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
