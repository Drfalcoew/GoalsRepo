//
//  ShortTermCell.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/11/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class ShortTermCell: UICollectionViewCell {
    
    //var tap : UITapGestureRecognizer!
    var icon : Int?
    var toggleInfo : Bool?
    
    
    let titleView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let moreInfoSpacerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let moreInfo : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.setImage(UIImage(named: "moreInfo"), for: .normal)
        return btn
    }()
    
    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.alpha = 0.6
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    let dateLabelView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white//(r: 75, g: 80, b: 120)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
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
        label.textColor = UIColor(r: 75, g: 80, b: 120)
        label.textAlignment = .left
        //label.sizeToFit()
        //label.backgroundColor = .blue
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
        
        self.dateLabelView.layer.cornerRadius = self.frame.height * 0.3

    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear//(r: 240, g: 240, b: 240)
        self.alpha = 1.0
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
        
        
        self.contentView.addSubview(moreInfoSpacerView)
        self.moreInfoSpacerView.addSubview(moreInfo)
        
        self.contentView.addSubview(titleView)
        self.titleView.addSubview(titleLabel)
        self.titleView.addSubview(categoryView)
        self.titleView.addSubview(dateLabelView)
        self.dateLabelView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        
        titleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3.3/4).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        moreInfoSpacerView.leftAnchor.constraint(equalTo: titleView.rightAnchor, constant: 0).isActive = true
        moreInfoSpacerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        moreInfoSpacerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        moreInfoSpacerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        moreInfo.centerYAnchor.constraint(equalTo: self.moreInfoSpacerView.centerYAnchor, constant: 0).isActive = true
        moreInfo.centerXAnchor.constraint(equalTo: self.moreInfoSpacerView.centerXAnchor, constant: 0).isActive = true
        moreInfo.widthAnchor.constraint(equalTo: self.moreInfoSpacerView.widthAnchor, multiplier: 0.8).isActive = true
        moreInfo.heightAnchor.constraint(equalTo: self.moreInfoSpacerView.widthAnchor, multiplier: 0.8).isActive = true
        
        categoryView.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor, constant: 0).isActive = true
        categoryView.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 0.8).isActive = true
        categoryView.rightAnchor.constraint(equalTo: self.titleView.rightAnchor, constant: -10).isActive = true
        categoryView.widthAnchor.constraint(equalToConstant: 12).isActive = true
    
        dateLabelView.leftAnchor.constraint(equalTo: self.titleView.leftAnchor, constant: 10).isActive = true
        dateLabelView.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor, constant: 0).isActive = true
        dateLabelView.heightAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 0.6).isActive = true
        dateLabelView.widthAnchor.constraint(equalTo: self.titleView.heightAnchor, multiplier: 0.6).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: self.dateLabelView.centerXAnchor, constant: 0).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.dateLabelView.centerYAnchor, constant: 0).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: self.dateLabelView.widthAnchor, multiplier: 0.85).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: self.dateLabelView.heightAnchor, multiplier: 0.85).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.dateLabelView.rightAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor, constant: 9).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.categoryView.leftAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: -2).isActive = true
        
    }
    
    func changeCategoryColor() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



