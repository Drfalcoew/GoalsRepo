//
//  ChartViewSubclass.swift
//  Sowing
//
//  Created by Drew Foster on 7/5/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ChartViewSubclass: UIView {
    
    let happyCount : Int? = UserDefaults.standard.integer(forKey: "happyCount")
    let sadCount : Int? = UserDefaults.standard.integer(forKey: "sadCount")
    var happyPercentage : Double?
    var sadPercentage : Double?

        
    let chartView_0 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    let chartView_1 : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "barChart")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.zPosition = 5 // uppermost layer
        return view
    }()
    
    let chartView_2 : UIView = { // base color of bar, fills whole bar
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 254, g: 218, b: 56)
        view.layer.zPosition = 3
        return view
    }()
    
    let chartView_3 : UIView = { // this color moves from bottom to top.
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 110, g: 175, b: 255)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.zPosition = 4
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupChart()
        setupViews()
        setupConstraints()
    }
    
    func setupChart() {
        if let x = happyCount, let y = sadCount {
            
            let total : Double = Double(x) + Double(y)
            if total == 0 { return }
            self.sadPercentage = Double(y) / total
        }
    }
    
    func setupViews() {
        //self.addSubview(chartView_0)
        self.addSubview(chartView_1)
        self.addSubview(chartView_2)
        self.addSubview(chartView_3)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            chartView_1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chartView_1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chartView_1.widthAnchor.constraint(equalTo: self.widthAnchor),
            chartView_1.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            chartView_2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chartView_2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chartView_2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            chartView_2.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 6.6/8),
            
            chartView_3.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            chartView_3.topAnchor.constraint(equalTo: self.chartView_2.bottomAnchor),
            chartView_3.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            chartView_3.heightAnchor.constraint(equalTo: self.chartView_2.heightAnchor, multiplier: 1)
            
        ])
        
        
    }
    
    func animateChart() {
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseIn) {
            self.chartView_3.center.y -= CGFloat(self.sadPercentage ?? 0) * self.chartView_2.frame.height
        } completion: { (nil) in }

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
