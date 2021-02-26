//
//  showSelectedGoal.swift
//  Sower
//
//  Created by Drew Foster on 3/10/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit

class ShowSelectedGoal : NSObject {
    
    let blackView = UIView()
    var viewController : UIViewController?
    
    let view : LongTermCellSubclassView = {
        let view = LongTermCellSubclassView()
        view.alpha = 0.0
        view.layer.cornerRadius = 10
        return view
    }()
    
    @objc func animateSelectedGoal() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(view)

            
            let x = window.frame.width * 0.05
            let y = UIApplication.shared.statusBarFrame.height + window.frame.height * 0.1
            self.blackView.frame = window.frame
            self.view.frame = CGRect(x: window.frame.width / 2, y: window.frame.height / 2, width: 0, height: 0)
            
            setupConstraints()

            //self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSettings)))
           
            UIView.animate(withDuration: 0.5, delay: 0.01, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.view.frame = CGRect(x: x, y: y, width: window.frame.width * 0.9, height: window.frame.height * 0.8)
                self.view.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc func dismissView() {
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -2.5
            let y = UIApplication.shared.statusBarFrame.height
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.0
                self.view.alpha = 0.0
                self.view.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height)
            }) { (true) in
                self.view.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    
    override init() {
        super.init()
        
    }
    
    func setupConstraints() {
        
    }
    
}
