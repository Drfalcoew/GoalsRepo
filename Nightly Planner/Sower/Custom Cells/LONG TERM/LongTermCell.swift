//
//  LongTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/18/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class LongTermCell: UICollectionViewCell {
    
    var x : CGFloat?

    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "tree_3")
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        img.layer.shadowOpacity = 0.2
        img.layer.shadowRadius = 5.0
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        
        
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
        
        setupViews()
    }
    
    
    func setupViews() {
        
        self.addSubview(image)
        self.addSubview(title)
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        title.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        title.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        title.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -25).isActive = true
        
        image.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: -5).isActive = true
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        image.widthAnchor.constraint(equalTo: self.image.heightAnchor, multiplier: 1).isActive = true
       
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(r: 75, g: 80, b: 120)
                self.title.textColor = .white
            }
            else {
                self.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                self.title.textColor = UIColor(r: 40, g: 43, b: 53)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
