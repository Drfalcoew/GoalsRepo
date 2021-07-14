//
//  GoalCounter.swift
//  Sower
//
//  Created by Drew Foster on 2/19/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class GoalCounter: UIView {
    
    let value : Double = 0.0
    var goals : Int = UserDefaults.standard.integer(forKey: "completedGoals")
    var totalGoals : Int? = UserDefaults.standard.integer(forKey: "totalGoals")
    
    let backView : UIView = {
        let view = UIView()
        view.layer.zPosition = 0
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let frameView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.backgroundColor = .clear
        view.layer.zPosition = 1
        return view
    }()
    
    var label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 35)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "  Goals Completed:  "
        lbl.textAlignment = .center
        return lbl
    }()
    
    let completionLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "0/3"
        lbl.layer.zPosition = 5
        lbl.textAlignment = .center
        return lbl
    }()
    
    var circularPath : UIBezierPath?
    fileprivate let shapeLayer = CAShapeLayer()
    fileprivate let pulsatingLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupConstraits()
        createCircle()
        setupGoals()
    }
    
    func setupGoals() {
        var _goals : Int
        var _total : Int
        _goals = self.goals
        if totalGoals ?? 3 > 0 {
            _total = self.totalGoals ?? 3
        } else {
            _total = 3
        }
        
        if _total <= _goals {
            let temp = Double(_goals) / 2 // 3, 7, 17, 42, 105, 262, 656
            _total = Int(Double(_total) * 1.3) + Int(temp)
        }
  
        completionLabel.text = "\(_goals)/\(_total)"
        UserDefaults.standard.setValue(_total, forKey: "totalGoals")
        
        UIView.animate(withDuration: 1.5, delay: 1.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.8, options: .curveEaseIn) {
            self.backView.alpha = 1.0
        } completion: { (true) in
            self.basicAnimation(goals: _goals, total: _total)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    func setupViews() {
        print("Inside Goal Counter Class")
        
        self.addSubview(backView)
        backView.addSubview(frameView)
        backView.addSubview(label)
        frameView.addSubview(completionLabel)
    }
    
    
    func createCircle() {
        let trackLayer = CAShapeLayer()
        let cent = CGPoint(x: frameView.bounds.midX, y: frameView.bounds.midY)
        print(cent)
        circularPath = UIBezierPath(arcCenter: cent, radius: backView.frame.height - 35, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulsatingLayer.fillColor = UIColor(r: 105, g: 120, b: 180).cgColor
        pulsatingLayer.path = circularPath?.cgPath
        pulsatingLayer.strokeColor = UIColor.clear.cgColor
        pulsatingLayer.lineWidth = 6
        pulsatingLayer.lineCap = .round
        
        animatePulsatingLayer()
        
        trackLayer.path = circularPath?.cgPath
        trackLayer.strokeColor = UIColor.white.cgColor
        trackLayer.lineWidth = 6
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.lightGray.cgColor
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.path = circularPath?.cgPath
        shapeLayer.strokeColor = UIColor(r: 75, g: 80, b: 120).cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        frameView.layer.addSublayer(pulsatingLayer)
        frameView.layer.addSublayer(trackLayer)
        frameView.layer.addSublayer(shapeLayer)
    }
    
    func setupConstraits() {
        NSLayoutConstraint.activate([
            backView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            backView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            backView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0),
            backView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0),
            
            frameView.heightAnchor.constraint(equalToConstant: 1),
            frameView.rightAnchor.constraint(equalTo: self.backView.rightAnchor, constant: -10),
            frameView.widthAnchor.constraint(equalTo: backView.heightAnchor, multiplier: 1.8/3),
            frameView.centerYAnchor.constraint(equalTo: self.backView.centerYAnchor, constant: 0),
            
            label.centerYAnchor.constraint(equalTo: frameView.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2),
            label.rightAnchor.constraint(equalTo: frameView.leftAnchor, constant: -60),
            
            completionLabel.centerXAnchor.constraint(equalTo: frameView.leftAnchor, constant: 0),
            completionLabel.centerYAnchor.constraint(equalTo: frameView.centerYAnchor, constant: 0),
            completionLabel.heightAnchor.constraint(equalTo: backView.heightAnchor, multiplier: 2/3),
            completionLabel.widthAnchor.constraint(equalTo: frameView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.1
        animation.toValue = 1.3
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    @objc func basicAnimation(goals: Int, total: Int) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        if total > 0 {
            basicAnimation.toValue = goals / total
        } else { basicAnimation.toValue = goals / 1 }
        basicAnimation.duration = 2
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "load")
    }
    
    func removeAnimations() {
        shapeLayer.removeAllAnimations()
        pulsatingLayer.removeAllAnimations()
    }
}
