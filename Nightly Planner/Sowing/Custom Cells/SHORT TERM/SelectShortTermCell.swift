//
//  selectShortTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 2/6/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class SelectShortTermCell: UITableViewCell {
    
    
    var leftLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(r: 36, g: 38, b: 48)
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var rightLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(r: 36, g: 38, b: 48)
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.contentView.addSubview(rightLabel)
        self.contentView.addSubview(leftLabel)
    }
    
    func setupConstraints() {
        leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        leftLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        leftLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        
        rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        rightLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        rightLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
