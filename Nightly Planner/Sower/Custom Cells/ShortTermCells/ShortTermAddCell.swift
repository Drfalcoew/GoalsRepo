//
//  ShortTermAddCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/25/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class ShortTermAddCell: UITableViewCell {

    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let categoryView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "add")
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let completionView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 2.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    override func layoutSubviews() {
        self.categoryViewBackground.layer.cornerRadius = self.categoryViewBackground.frame.size.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        setupViews()
        setupConstraints()
    }
    
    
    
    func setupViews() {
        
        self.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        self.selectionStyle = .none
        
        
        self.contentView.addSubview(categoryViewBackground)
        categoryViewBackground.addSubview(categoryView)
        
        
    }
    
    func setupConstraints() {
        
        categoryViewBackground.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryViewBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        categoryViewBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        categoryViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        categoryView.widthAnchor.constraint(equalTo: categoryViewBackground.widthAnchor, multiplier: 0.55).isActive = true
        categoryView.heightAnchor.constraint(equalTo: categoryViewBackground.heightAnchor, multiplier: 0.55).isActive = true
        categoryView.centerYAnchor.constraint(equalTo: categoryViewBackground.centerYAnchor, constant: 0).isActive = true
        categoryView.centerXAnchor.constraint(equalTo: categoryViewBackground.centerXAnchor, constant: 0).isActive = true
        
        
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



