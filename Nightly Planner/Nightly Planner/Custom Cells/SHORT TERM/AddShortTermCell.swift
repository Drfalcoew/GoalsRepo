//
//  AddShortTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/31/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class AddShortTermCell: UICollectionViewCell {
    
    let addGoal : UIButton = {
        let view = UIButton()
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.isHidden = false
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let categoryView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "add")
        view.isHidden = false
        view.tintImageColor(color: .white)
        return view
    }()
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        
        self.layer.cornerRadius = 20
        addGoal.layer.cornerRadius = self.frame.size.height / 4
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        self.clipsToBounds = true
        
        
        //self.selectionStyle = .none
        
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        self.alpha = 0.9
        self.contentView.addSubview(addGoal)
        addGoal.addSubview(categoryView)
    }
    
    func setupConstraints() {
        
        addGoal.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        addGoal.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        addGoal.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        addGoal.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        
        categoryView.widthAnchor.constraint(equalTo: addGoal.widthAnchor, multiplier: 0.55).isActive = true
        categoryView.heightAnchor.constraint(equalTo: addGoal.heightAnchor, multiplier: 0.55).isActive = true
        categoryView.centerYAnchor.constraint(equalTo: addGoal.centerYAnchor, constant: 0).isActive = true
        categoryView.centerXAnchor.constraint(equalTo: addGoal.centerXAnchor, constant: 0).isActive = true
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
