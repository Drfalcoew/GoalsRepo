//
//  CollaborationsSubclass.swift
//  Sowing
//
//  Created by Drew Foster on 7/8/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CollaborationsSubclass : UIView {
    
    let titleView : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.numberOfLines = 2
        lbl.text = "Coming soon. Version 3.0"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(titleView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.titleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            self.titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
        ])
    }
    
}

