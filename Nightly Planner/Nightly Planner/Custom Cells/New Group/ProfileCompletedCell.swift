//
//  ProfileCompletedCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 3/16/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class ProfileCompletedCell: UITableViewCell {
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 40)
        label.layer.masksToBounds = true
        label.numberOfLines = 2
        label.textColor = UIColor(r: 40, g: 43, b: 53)
        label.textAlignment = .left
        label.sizeToFit()
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintImageColor(color: .white)
        img.layer.masksToBounds = true
        img.isHidden = false
        return img
    }()
    
    let daysTaken : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.textColor = UIColor.gray
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingHead
        lbl.alpha = 0.7
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(daysTaken)
        
        
        //self.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        self.selectionStyle = .none
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                //self.nameLabel.textColor = UIColor(r: 40, g: 43, b: 53)
                
            }
            else {
                //self.nameLabel.textColor = UIColor(r: 221, g: 221, b: 221)
            }
        }
    }
    
    func setupConstraints() {
        daysTaken.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        daysTaken.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        daysTaken.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1/4).isActive = true
        daysTaken.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
}
