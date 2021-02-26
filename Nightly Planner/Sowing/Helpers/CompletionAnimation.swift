 //
 //  CompletionAnimation.swift
 //  Nightly Planner
 //
 //  Created by Drew Foster on 2/18/19.
 //  Copyright © 2019 Drew Foster. All rights reserved.
 //
 
 import UIKit
 import Foundation
 
 class CompletionAnimation: UIViewController {
    
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In VIEW DID LOAD")
        
        
        runAnimation()
    }

    
    func runAnimation() {
        print("IN RUN ANIMATION")
        if running != true {
            
            running = true
            blackView.alpha = 0
            swordView.alpha = 0.0
            completedView.alpha = 0.0
            
            blackView.frame = view.frame
            completedView.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height - self.view.frame.height / 10 * 3.25, width: self.view.frame.width * 2/3, height: completedView.frame.width / 5)
            
            swordView.frame = CGRect(x: 0 - self.view.frame.width * 1/3, y: self.view.frame.minY + self.view.frame.height / 10 * 3.25, width: self.view.frame.width * 2/3, height: swordView.frame.width / 3)
            
            
            print("INSIDE ANIMATION CLOSURE")
            self.view.addSubview(blackView)
            self.view.addSubview(swordView)
            self.view.addSubview(completedView)
            
            
            UIView.animate(withDuration: 0.35, delay: 0.5, options: UIView.AnimationOptions.curveLinear, animations: {
                print("1")
                self.blackView.alpha = 0.8
                self.swordView.alpha = 1
                self.completedView.alpha = 1
                
                self.swordView.center.x = 0 + self.swordView.frame.width / 2 + 15
                self.completedView.center.x = self.view.frame.width - self.completedView.frame.width / 2 - 15
                
            }) { (true) in
                UIView.animate(withDuration: 1.35, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                    print("2")
                    
                    self.swordView.center.x = self.swordView.center.x + self.view.frame.width * 1/3
                    self.completedView.center.x = self.completedView.center.x - self.view.frame.width * 1/3

                }, completion: { (true) in
                    UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                        print("3")
                        
                        self.swordView.center.x = self.view.frame.width + self.swordView.frame.width / 2 + 10
                        self.completedView.center.x = 0 - self.completedView.frame.width / 2 - 10

                        self.swordView.alpha = 0
                        self.completedView.alpha = 0
                    }, completion: { (true) in
                        self.view.willRemoveSubview(self.swordView)
                        self.swordView.removeFromSuperview()
                        self.view.willRemoveSubview(self.swordView)
                        self.view.willRemoveSubview(self.completedView)
                        self.swordView.removeFromSuperview()
                        self.completedView.removeFromSuperview()
                        UIView.animate(withDuration: 0.5, animations: {
                            self.blackView.alpha = 0
                        })
                        self.view.willRemoveSubview(self.blackView)
                        self.blackView.removeFromSuperview()
                        self.running = false
                    })
                })
            }
        }
    }
    
    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let swordView : UIImageView = {
        let view = UIImageView()
        view.alpha = 0
        view.image = UIImage(named: "GreatSword")
        return view
    }()
    
    let completedView : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "complete")
        img.alpha = 0
        return img
    }()
    
    
 }
