//
//  Vision.swift
//  Sowing
//
//  Created by Drew Foster on 5/19/21.
//  Copyright © 2021 Drew Foster. All rights reserved.
//

import Foundation
import UIKit


class Vision: NSObject, UIGestureRecognizerDelegate {
 
    
    let titleText : [String] = ["Home", "Vision", "Profile", "Settings"]
    let cellId = "cellId"
    let blackView = UIView()
    var viewController : UIViewController?
    let vc : [UIViewController] = [ViewController(), GoalViewController(), ProfileViewController()]
    
    var tap : UITapGestureRecognizer?

    
    let backView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.layer.zPosition = 2
        return view
    }()
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "back"
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.layer.zPosition = 3
        lbl.isHidden = true
        lbl.isUserInteractionEnabled = false
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
        
    let menuView : UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.layer.zPosition = 1
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    @objc func Settings() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(menuView)
            
            let x = window.frame.width / -0.8
            let y = window.frame.height * 0.1
            self.blackView.frame = window.frame
            self.menuView.frame = CGRect(x: x - 5, y: y, width: window.frame.width / 0.8, height: window.frame.height * 0.8)
            
            setupConstraints()
            
           
            UIView.animate(withDuration: 0.35, delay: 0.01, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.menuView.frame = CGRect(x: 0, y: y, width: window.frame.width / 0.8, height: window.frame.height * 0.8)
                self.menuView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc func dismissSettings() {
        print("TESTING")
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -0.9
            let y = UIApplication.shared.statusBarFrame.height
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width / 0.8, height: window.frame.height)
            }) { (true) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    
    override init() {
        super.init()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissSettings))
        tap?.delegate = self
        
        backView.addGestureRecognizer(tap!)
        
        setupViews()
    }
    
    func setupViews() {
        menuView.addSubview(backView)
        menuView.addSubview(title)
    }
    
    @objc func settingsHandler() {
        print("Settings button touched")
        
        title.textColor = UIColor(r: 75, g: 80, b: 120)
        
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width * -0.8
            let y = window.frame.height * 0.1
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width * 0.8, height: window.frame.height * 0.8)
            }) { (completed: Bool) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
                self.viewController?.navigationController?.customPush(viewController: SettingsViewController())
                self.title.textColor = UIColor(r: 75, g: 80, b: 120)
            }
        }
    }
    
    func setupConstraints() {
        
        backView.topAnchor.constraint(equalTo: self.menuView.topAnchor, constant: 15).isActive = true
        backView.leftAnchor.constraint(equalTo: self.menuView.leftAnchor, constant: 10).isActive = true
        backView.widthAnchor.constraint(equalTo: self.menuView.widthAnchor, multiplier: 0.5).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        title.centerXAnchor.constraint(equalTo: backView.centerXAnchor, constant: 0).isActive = true
        title.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true
        title.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 1).isActive = true
        title.heightAnchor.constraint(equalTo: backView.heightAnchor, multiplier: 1).isActive = true
    }
}
