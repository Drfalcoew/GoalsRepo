//
//  AddLongTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/7/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class AddLongTermCell: UICollectionViewCell {
    
    
    let goalCategoryIcon : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let setFocusLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Set Focus"
        lbl.layer.masksToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "San Francisco", size: 40)
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
        self.layer.cornerRadius = 2
        self.categoryViewBackground.layer.cornerRadius = self.frame.height * 0.65 / 2
        //self.backgroundColor = UIColor(r: 211, g: 211, b: 211)

        
        self.addSubview(categoryViewBackground)
        categoryViewBackground.addSubview(goalCategoryIcon)
        
        
        categoryViewBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        categoryViewBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        categoryViewBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        categoryViewBackground.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65).isActive = true
        
        goalCategoryIcon.widthAnchor.constraint(equalTo: categoryViewBackground.widthAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.heightAnchor.constraint(equalTo: categoryViewBackground.heightAnchor, multiplier: 0.55).isActive = true
        goalCategoryIcon.centerYAnchor.constraint(equalTo: categoryViewBackground.centerYAnchor, constant: 0).isActive = true
        goalCategoryIcon.centerXAnchor.constraint(equalTo: categoryViewBackground.centerXAnchor, constant: 0).isActive = true
        
        
    }
    
    
    @objc func handleAddGoal(sender: UIButton) {
        
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(myAlert, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

