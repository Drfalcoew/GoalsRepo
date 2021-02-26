//
//  SelectedShortTermCellItem2.swift
//  Nightly Planner
//
//  Created by Drew Foster on 2/10/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class SelectedShortTermCellItem2: UITableViewCell {
    
    
    
    var lblOne : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 1
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        //lbl.text = "Price to pay:"
        return lbl
    }()
    
    var lblTwo: UITextField = {
        let lbl = UITextField()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        //lbl.text = "(ex: 1 year in Taekwondo class)"
        lbl.textColor = .gray
        lbl.isUserInteractionEnabled = false
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        return lbl
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        setupViews()
        setupConstraints()
    }
    
    
    func setupViews() {
        self.selectionStyle = .none
      
        
        self.contentView.addSubview(lblOne)
        self.contentView.addSubview(lblTwo)
    }
    
    func setupConstraints() {
        lblOne.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        lblOne.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        lblOne.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        lblOne.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        lblTwo.topAnchor.constraint(equalTo: lblOne.bottomAnchor, constant: 12).isActive = true
        lblTwo.leftAnchor.constraint(equalTo: lblOne.leftAnchor, constant: 12).isActive = true
        lblTwo.heightAnchor.constraint(lessThanOrEqualToConstant: self.contentView.frame.height - lblOne.frame.height - 24)
        lblTwo.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -24).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
