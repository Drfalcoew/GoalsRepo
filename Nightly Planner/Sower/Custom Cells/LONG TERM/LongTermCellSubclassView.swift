//
//  LongTermCellSubclassView.swift
//  Sower
//
//  Created by Drew Foster on 3/9/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class LongTermCellSubclassView: UICollectionViewCell {
    
    
    let deadline : UILabel = {
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
        lbl.alpha = 0.85
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let level : UILabel = {
        let lbl = UILabel()
        lbl.text = "Goal Level:"
        lbl.layer.masksToBounds = true
        //lbl.numberOfLines = 1
        //lbl.lineBreakMode = .byTruncatingMiddle
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        //lbl.font = UIFont.boldSystemFont(ofSize: 35)
        lbl.textAlignment = .left
        lbl.minimumScaleFactor = 0.5
        lbl.alpha = 0.85
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let activeTasks : UILabel = {
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
        lbl.alpha = 0.85
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let completedTasks : UILabel = {
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
        lbl.alpha = 0.85
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    let dateCreated : UILabel = {
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
        lbl.alpha = 0.85
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    
    let goalIcon : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 35.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.layer.masksToBounds = false
        return view
    }()


    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        //self.addSubview(deadline)
        self.addSubview(goalIcon)
    }
    
    
    
   
    
    func setupConstraints() {
        goalIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        goalIcon.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: self.frame.height * 0.10).isActive = true
        goalIcon.widthAnchor.constraint(equalTo: self.goalIcon.heightAnchor, multiplier: 1.0).isActive = true
        goalIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        //self.backgroundColor = .lightGray
        //longTermLabel.backgroundColor = .darkGray
        /*deadline.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        deadline.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        deadline.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deadline.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
*/
    }
    
    
    
}
