//
//  imbedShortTerm.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/9/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class imbedShortTermCell: UICollectionViewCell {
    
    
    var widthHeight : CGFloat?
    
    var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Long term goal name "
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true

        lbl.textAlignment = .right
        lbl.textColor = UIColor(r: 186, g: 186, b: 186)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.isHidden = false
        return lbl
    }()
    
    let dateImageView : UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = CGFloat(0.5)
        view.layer.borderColor = UIColor(r: 125, g: 200, b: 180).cgColor
        return view
    }()
    
    var dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Jun 23"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 125, g: 200, b: 180)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.isHidden = false
        return lbl
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateImageView.layer.cornerRadius = self.dateImageView.frame.height / 2
    }
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        dateImageView.layer.cornerRadius = self.frame.size.height * 0.45
        self.layer.cornerRadius = 20
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.alpha = 0
        //self.selectionStyle = .none
        
        self.clipsToBounds = true
        
        if let window = UIApplication.shared.keyWindow {
            //widthHeight = self.frame.height - (self.frame.height * 0.15)
            widthHeight = (window.frame.height / 6) - (window.frame.height * 0.05)
        }

        
        setupViews()
        setupConstraints()
    }
   
    func setupViews() {
        self.contentView.addSubview(titleLabel)
        
        self.contentView.addSubview(dateImageView)
        self.dateImageView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        dateImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        dateImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        dateImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        dateImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        
        dateLabel.centerXAnchor.constraint(equalTo: self.dateImageView.centerXAnchor, constant: 0).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.dateImageView.centerYAnchor, constant: 0).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: self.dateImageView.widthAnchor, multiplier: 0.85).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: self.dateImageView.heightAnchor, multiplier: 0.85).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: self.dateImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        
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
