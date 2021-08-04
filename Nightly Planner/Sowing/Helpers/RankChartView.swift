//
//  RankChartView.swift
//  Sowing
//
//  Created by Drew Foster on 7/12/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class RankChartView: UIView {
    
    
    var myPosition : Double!
    
    let titles : [String] = ["", "Apprentice", "Gardener", "Sharecropper", "Farmer", "Greenthumb", "Agronomist", "Master Sower", "Grand Master Sower"]
    let levels : [Int] = [0, 3, 5, 8, 14, 25, 45, 82, 151]
    
    var goals : Int = UserDefaults.standard.integer(forKey: "completedGoals")
    var totalGoals : Int? = UserDefaults.standard.integer(forKey: "totalGoals")
    
    let graphView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    let topLblTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.minimumScaleFactor = 0.2
        lbl.backgroundColor = .white
        lbl.layer.zPosition = 10
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 26)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let topLblNum : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 19)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let bottomLblTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.minimumScaleFactor = 0.2
        lbl.backgroundColor = .white
        lbl.layer.zPosition = 10
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 26)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let bottomLblNum : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 19)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let myRank : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        setupGraph()
        setupViews()
        setupConstraints()
    }
    
    func setupGraph() {
        var _index : Int = 0
        
        if totalGoals ?? 3 <= 150 {
            if let _temp = levels.firstIndex(where: { $0 == totalGoals }) {
                if _temp > 0 {
                    _index = _temp - 1
                } else { _index = _temp }
            }
            
            let n = Double(goals) - Double(levels[_index])
            let d = Double(levels[_index + 1]) - Double(levels[_index])
            myPosition = n / d
            
            topLblTitle.text = titles[_index + 1]
            topLblNum.text = String(levels[_index + 1])
            bottomLblTitle.text = titles[_index]
            bottomLblNum.text = String(levels[_index])
        } else {
            myPosition = 1
            topLblTitle.text = titles[8]
            topLblNum.text = String(levels[8])
            bottomLblTitle.text = titles[7]
            bottomLblNum.text = String(levels[7])
        }
    }
    
    func animateGraph() {
        
        print(myPosition)
        
        UIView.animate(withDuration: 2.0, delay: 0.2, options: .curveEaseOut) {
            self.myRank.center.y -= (self.frame.height * 0.7) * (CGFloat(self.myPosition))
        } completion: { (nil) in }
    }
    
    func setupViews() {
        self.addSubview(graphView)
        self.addSubview(topLblTitle)
        self.addSubview(topLblNum)
        self.addSubview(bottomLblTitle)
        self.addSubview(bottomLblNum)
        self.addSubview(myRank)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            graphView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            graphView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            graphView.widthAnchor.constraint(equalToConstant: 1),
            graphView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            topLblTitle.leftAnchor.constraint(equalTo: self.graphView.leftAnchor, constant: 12),
            topLblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topLblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.2/3.3),
            topLblTitle.heightAnchor.constraint(equalTo: self.topLblTitle.widthAnchor, multiplier: 1/4),
            
            bottomLblTitle.leftAnchor.constraint(equalTo: self.graphView.leftAnchor, constant: 12),
            bottomLblTitle.heightAnchor.constraint(equalTo: self.topLblTitle.heightAnchor, multiplier: 1),
            bottomLblTitle.widthAnchor.constraint(equalTo: self.topLblTitle.widthAnchor, multiplier: 1),
            bottomLblTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            bottomLblNum.leftAnchor.constraint(equalTo: graphView.rightAnchor, constant: 12),
            bottomLblNum.bottomAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 0),
            bottomLblNum.heightAnchor.constraint(equalTo: topLblTitle.heightAnchor, constant: 0),
            bottomLblNum.widthAnchor.constraint(equalToConstant: 50),
            
            topLblNum.leftAnchor.constraint(equalTo: graphView.rightAnchor, constant: 12),
            topLblNum.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 5),
            topLblNum.heightAnchor.constraint(equalTo: topLblTitle.heightAnchor, constant: 0),
            topLblNum.widthAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    override func layoutSubviews() {

        myRank.frame = CGRect(x: graphView.frame.midX + 10, y: self.frame.height - self.frame.height * 0.15 - 10, width: 20, height: 20)
        
        myRank.layer.cornerRadius = self.myRank.frame.width / 2
        
        animateGraph()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
