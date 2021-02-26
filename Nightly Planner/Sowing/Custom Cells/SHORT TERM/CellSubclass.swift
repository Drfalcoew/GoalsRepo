
//
//  cellSubclas.swift
//  Test
//
//  Created by Drew Foster on 4/9/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class cellSubclass: UITableViewCell {
    
    let textField : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.text = "0"
        return text
    }()
    
    let stepperButton : UIStepper = {
        let step = UIStepper()
        step.translatesAutoresizingMaskIntoConstraints = false
        step.layer.masksToBounds = true
        step.minimumValue = 0
        return step
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
        
        self.contentView.addSubview(textField)
        self.contentView.addSubview(stepperButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            
            stepperButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stepperButton.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor, constant: 8),
            stepperButton.heightAnchor.constraint(equalToConstant: 50),
            stepperButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
    }
    
    
}
