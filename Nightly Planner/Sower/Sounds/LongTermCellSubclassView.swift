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
       
        view.layer.masksToBounds = false
        view.layer.zPosition = 5
        return view
    }()
    
    let backgroundImg : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "bg")
        view.layer.masksToBounds = true
        view.layer.isHidden = false
        return view
    }()
    
    let cloud_0 : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "cloud_0")
        view.layer.masksToBounds = true
        view.layer.isHidden = false
        return view
    }()
    
    let cloud_1 : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "cloud_1")
        view.layer.masksToBounds = true
        view.layer.isHidden = false
        return view
    }()
    
    let cloud_2 : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "cloud_2")
        view.layer.masksToBounds = true
        view.layer.isHidden = false
        return view
    }()
    
    let cloud_3 : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "cloud_3")
        view.layer.masksToBounds = true
        view.layer.isHidden = false
        return view
    }()


    let viewBG : UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        viewBG.image = UIImage(named: "background_2")
        viewBG.frame = self.frame

        self.addSubview(viewBG)
        viewBG.addSubview(goalIcon)
        viewBG.addSubview(cloud_0)
        goalIcon.isHidden = false
        viewBG.addSubview(backgroundImg)
    }
    
    
    func animate() {
        repeat { cloud_0.frame.origin.x -= 1
        } while cloud_0.frame.origin.x > 0
    }
    
    
    func setupConstraints() {
        cloud_0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        cloud_0.heightAnchor.constraint(equalTo: self.cloud_0.widthAnchor, multiplier: 0.53).isActive = true
        cloud_0.frame.origin.x = self.frame.width + 200
        
        goalIcon.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6 ,constant: 0).isActive = true
        goalIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        goalIcon.widthAnchor.constraint(equalTo: self.goalIcon.heightAnchor, multiplier: 1.0).isActive = true
        goalIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        //self.backgroundColor = .lightGray
        //longTermLabel.backgroundColor = .darkGray
        /*deadline.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        deadline.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        deadline.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        deadline.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
*/
        backgroundImg.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        backgroundImg.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        backgroundImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        backgroundImg.heightAnchor.constraint(equalTo: self.backgroundImg.widthAnchor, multiplier: 0.9).isActive = true

        cloud_0.bottomAnchor.constraint(equalTo: self.backgroundImg.centerYAnchor, constant: -20).isActive = true
    }
    
}
