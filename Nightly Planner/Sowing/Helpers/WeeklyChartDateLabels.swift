//
//  WeeklyChartDateLabels.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/15/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit

class WeeklyChartDateLabels: UIView {
    
    var labels : [String] = ["1/1", "1/1", "1/1", "1/1", "1/1", "1/1", "1/1"]
    
    
    var date_0 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 201, g: 201, b: 201)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_1 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 261, g: 261, b: 261)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_2 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 201, g: 201, b: 201)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_3 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 261, g: 261, b: 261)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_4 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 201, g: 201, b: 201)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_5 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 261, g: 261, b: 261)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    var date_6 : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica Neue", size: 13)
        lbl.textColor = UIColor(r: 201, g: 201, b: 201)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.1
        lbl.alpha = 0.5
        lbl.textAlignment = .center

        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(date_0)
        self.addSubview(date_1)
        self.addSubview(date_2)
        self.addSubview(date_3)
        self.addSubview(date_4)
        self.addSubview(date_5)
        self.addSubview(date_6)
        
        initializeLabels()
        setupLabels()
        addBehavior()
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior() {
        
        self.layer.cornerRadius = 5
    }
    
    func initializeLabels() {
        var newString : String
        for i in 0 ... 6 {  // gets and sets last 7 days of the week
            newString = Date().getDay(days: -(i)).formatted
            //print("15 ", newString, newString.count)
            if newString.count > 9 {
                self.labels[i] = newString[0...4]
                print("15 0 ", labels[i])
                
                
            } else if newString.count == 9 {
                self.labels[i] = newString[0...3]
                print("15 1 ", labels[i])
                
                
            } else if newString.count < 9 {
                self.labels[i] = newString[0...2]
                print("15 2 ", labels[i])
                
            } else {
                self.labels[i] = "Error"
                print("15 3 ", labels[i])
                
            }
        }
        
        if UIScreen.main.bounds.width > 1500 {
            date_0.font = UIFont(name: "Helvetica Neue", size: 20)
        }

    }
    
    func setupLabels() {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        let date = Calendar.current.date(from: dateComponents)

        
        date_0.text = labels[6]
        date_1.text = labels[5]
        date_2.text = labels[4]
        date_3.text = labels[3]
        date_4.text = labels[2]
        date_5.text = labels[1]
        date_6.text = labels[0]
    }
    
    func setupConstraints() {
        
        date_0.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_0.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        date_0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_0.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_1.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_1.leftAnchor.constraint(equalTo: self.date_0.rightAnchor, constant: 0).isActive = true
        date_1.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_2.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_2.leftAnchor.constraint(equalTo: self.date_1.rightAnchor, constant: 0).isActive = true
        date_2.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_3.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_3.leftAnchor.constraint(equalTo: self.date_2.rightAnchor, constant: 0).isActive = true
        date_3.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_4.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_4.leftAnchor.constraint(equalTo: self.date_3.rightAnchor, constant: 0).isActive = true
        date_4.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_4.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_5.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_5.leftAnchor.constraint(equalTo: self.date_4.rightAnchor, constant: 0).isActive = true
        date_5.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_5.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
        date_6.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        date_6.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        date_6.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        date_6.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/7).isActive = true
        
    }
}
