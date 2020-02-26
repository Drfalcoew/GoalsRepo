//
//  ShortTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/11/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class ShortTermCell: UICollectionViewCell {
    
    var tap : UITapGestureRecognizer!
    var icon : Int?
    var toggleInfo : Bool?
    
    let categoryView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        view.layer.cornerRadius = 5
        return view
    }()

    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "San Francisco", size: 40)
        label.layer.masksToBounds = true
        label.numberOfLines = 2
        label.textColor = UIColor(r: 40, g: 43, b: 53)
        label.textAlignment = .left
        //label.sizeToFit()
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.textColor = UIColor(r: 40, g: 43, b: 53)
        label.textAlignment = .left
        label.sizeToFit()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let daysTaken : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        //lbl.textColor = UIColor.black
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.alpha = 1
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
   
    
    /*let categoryView : UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        //view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.image = UIImage(named: "icon_7")
        view.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
        return view
    }()*/
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        self.alpha = 1.0
        self.layer.cornerRadius = 5
        if let window = UIApplication.shared.keyWindow {
            if window.frame.height > 700 {
                titleLabel.font = UIFont.boldSystemFont(ofSize: 35.0)
            } else {
                titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            }
        }
        
        if icon != nil {
            print(icon!)
           // categoryView.image = UIImage(named: "\(icon!)")
            //categoryView.isHidden = false
        } else {
           // categoryView.isHidden = true
        }
        
        setupViews()
        setupConstraints()
    }
    
    
  /*  override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(r: 70, g: 74, b: 84)
            }
            else {
                self.backgroundColor = UIColor(r: 60, g: 63, b: 73)
            }
        }
    }*/
    
    
    func setupViews() {
        
        self.contentView.addSubview(daysTaken)
        //self.contentView.addSubview(subLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryView)
    }
    
    func setupConstraints() {
        
        categoryView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        categoryView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        categoryView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        categoryView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        
        daysTaken.rightAnchor.constraint(equalTo: self.categoryView.leftAnchor, constant: -5).isActive = true
        daysTaken.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        daysTaken.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        daysTaken.widthAnchor.constraint(equalTo: daysTaken.heightAnchor, multiplier: 0.8).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 9).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.daysTaken.leftAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



