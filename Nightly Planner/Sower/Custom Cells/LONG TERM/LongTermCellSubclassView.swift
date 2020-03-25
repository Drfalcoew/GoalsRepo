//
//  LongTermCellSubclassView.swift
//  Sower
//
//  Created by Drew Foster on 3/9/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class LongTermCellSubclassView: UIView {
    
    let goalName : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.layer.masksToBounds = true
        //lbl.numberOfLines = 1
        //lbl.lineBreakMode = .byTruncatingMiddle
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        //lbl.font = UIFont.boldSystemFont(ofSize: 35)
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.alpha = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let goalIcon : UIImageView = {
        let view = UIImageView()
        //view.tintImageColor(color: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 20.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.layer.masksToBounds = true
        return view
    }()
    
    /*let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(5)
        view.layer.borderColor = UIColor(r: 242, g: 182, b: 255).cgColor
        view.backgroundColor = UIColor.clear//(r: 163, g: 171, b: 199)
        return view
    }()*/

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.layer.cornerRadius = 2
        self.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 20.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
        
        self.addSubview(goalName)
        self.addSubview(goalIcon)
    }
    
    func setupConstraints() {
        goalIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40).isActive = true
        goalIcon.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        goalIcon.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5, constant: 40).isActive = true
        goalIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        //self.backgroundColor = .lightGray
        //longTermLabel.backgroundColor = .darkGray
        goalName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        goalName.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        goalName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        goalName.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true

    }
    
    
    
}
