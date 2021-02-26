//
//  MenuCells.swift
//  Nightly Planner
//
//  Created by Hand Of The King on 2/19/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
        return img
    }()
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(image)
        self.addSubview(title)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2.5).isActive = true
        image.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2.5).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        title.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 3/5).isActive = true
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                title.textColor = UIColor(r: 221, g: 221, b: 221)
                image.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
            } else {
                title.textColor = UIColor(r: 75, g: 80, b: 120)
                image.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
            }
        }
    }
    
    /*override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(r: 125, g: 200, b: 180)
            }
            else {
                self.backgroundColor = .clear
            }
        }
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
