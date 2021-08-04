//
//  ReflectionSubclass.swift
//  Sowing
//
//  Created by Drew Foster on 5/26/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ReflectionSubclass : UIView {
    
    var tap : UITapGestureRecognizer?
    let happyCount : Int? = UserDefaults.standard.integer(forKey: "happyCount")
    let sadCount : Int? = UserDefaults.standard.integer(forKey: "sadCount")
    let reset = UserDefaults.standard.string(forKey: "reflectionDate")
    
    var chartView_LeftAnchor : NSLayoutConstraint?
    
    let outerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.layer.cornerRadius = 5
        return view
    }()
    
    let chartView : ChartViewSubclass = {
        let view = ChartViewSubclass()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var happyPercentage : Double?
    var sadPercentage : Double?
    
    let reflectionLabel : UILabel = {
        let lbl = UILabel()
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.text = "Self-Reflection"
        lbl.font = UIFont(name: "Helvetica Neue", size: 23)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.isHidden = true // does not look too clean
        return lbl
    }()
    
    let badButton : ReflectionButton = {
        let btn = ReflectionButton()
        btn.setImage(UIImage(named: "sadIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.layer.borderWidth = 0.25
        btn.tag = 1
        btn.alpha = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleGoodBad), for: .touchUpInside)
        return btn
    }()
    
    let goodButton : ReflectionButton = {
        let btn = ReflectionButton()
        btn.setImage(UIImage(named: "happyIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.alpha = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleGoodBad), for: .touchUpInside)
        return btn
    }()
        
    override func layoutSubviews() {
        self.goodButton.layer.cornerRadius = self.frame.width * 0.08
        self.badButton.layer.cornerRadius = self.frame.width * 0.08
        
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tap = UITapGestureRecognizer(target: self, action: #selector(handleChartTap))
        
        setupViews()
        setupConstraints()
        updatePercentage()

    }
    
    func setupViews() {
        self.addSubview(reflectionLabel)
        self.addSubview(outerView)
        self.outerView.addSubview(goodButton)
        self.outerView.addSubview(badButton)
        self.addSubview(chartView)
        
        chartView.addGestureRecognizer(tap!)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            outerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            outerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            outerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            outerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            reflectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            reflectionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            reflectionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2.3),
            reflectionLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
                                    
            badButton.topAnchor.constraint(equalTo: self.outerView.centerYAnchor, constant: 5),
            badButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.78),
            badButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.78),
            badButton.centerXAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: 0),
            
            goodButton.centerXAnchor.constraint(equalTo: self.outerView.centerXAnchor, constant: 0),
            goodButton.bottomAnchor.constraint(equalTo: self.outerView.centerYAnchor, constant: -5),
            goodButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            goodButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            chartView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            chartView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            chartView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        
        chartView_LeftAnchor = chartView.leftAnchor.constraint(equalTo: self.rightAnchor)

        chartView_LeftAnchor?.isActive = true
        
        

    }
    
    func updatePercentage() {
        
        if reset == Date().toString() {
            chartView.setupChart()
            outerView.isHidden = true
            
            chartView_LeftAnchor?.isActive = false
            chartView_LeftAnchor = chartView.leftAnchor.constraint(equalTo: self.leftAnchor)
            chartView_LeftAnchor?.isActive = true

            self.chartView.animateChart()
            
        } else {
            
            chartView_LeftAnchor?.isActive = false
            chartView_LeftAnchor = chartView.leftAnchor.constraint(equalTo: self.rightAnchor)
            chartView_LeftAnchor?.isActive = true

        }

        
        if let x = happyCount, let y = sadCount {
            let total = x + y
            if total == 0 { return }
            self.happyPercentage = Double(x / total)
            self.sadPercentage = 100.0 - happyPercentage!
        }
    }
    
    @objc func handleGoodBad(sender: UIButton) {
        
        UserDefaults.standard.setValue(Date().toString(), forKey: "reflectionDate")

        if sender.tag == 0 {
            let happyCount : Int = UserDefaults.standard.integer(forKey: "happyCount")
            UserDefaults.standard.setValue(happyCount + 1, forKey: "happyCount")
            UserDefaults.standard.synchronize()

            // good
            
        } else if sender.tag == 1 {
            let sadCount : Int = UserDefaults.standard.integer(forKey: "sadCount")
            UserDefaults.standard.setValue(sadCount + 1, forKey: "sadCount")
            UserDefaults.standard.synchronize()

            // bad
            
        }
        
        chartView.setupChart()
        
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn) {
            self.outerView.center.x += self.outerView.frame.width + 5
        } completion: { (true) in
            UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn) {
                self.chartView.center.x -= self.chartView.frame.width + 5
            } completion: { (true) in
                self.chartView.animateChart()
            }
        }

    }
    
    @objc func handleChartTap() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "handleChartTap"), object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
}
