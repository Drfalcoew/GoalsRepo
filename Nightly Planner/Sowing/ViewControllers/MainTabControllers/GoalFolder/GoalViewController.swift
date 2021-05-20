//
//  FocusViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 4/1/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//
//

import UIKit
import SpriteKit
import GameplayKit

class GoalViewController: UIViewController {
    
    let vision = UserDefaults.standard.string(forKey: "vision")
    let visionActive = UserDefaults.standard.bool(forKey: "visionActive")
    
    let visionButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "visionIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 5
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleAddVision), for: .touchUpInside)
        btn.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        return btn
    }()
    
    let goodBadButton : GoodBadButton = {
        let btn = GoodBadButton()
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.layer.borderWidth = 0.25
        btn.tag = 2
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleGoodBad), for: .touchUpInside)
        return btn
    }()

    
    let badButton : GoodBadButton = {
        let btn = GoodBadButton()
        btn.setImage(UIImage(named: "sadIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.alpha = 0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleGoodBad), for: .touchUpInside)
        return btn
    }()
    
    let goodButton : GoodBadButton = {
        let btn = GoodBadButton()
        btn.setImage(UIImage(named: "happyIcon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 0
        btn.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.alpha = 0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleGoodBad), for: .touchUpInside)
        return btn
    }()
    
    let visionLabel : UITextView = {
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.textColor = UIColor.white
        lbl.isScrollEnabled = true
        lbl.layer.cornerRadius = 5
        lbl.alpha = 0
        lbl.layer.zPosition = 1
        lbl.backgroundColor = .clear
        lbl.text = "The paragraph you distill should be enjoyable for you to read aloud. It should inspire you and bring a smile to your face to think about this being your new reality. Most especially it should feel like you, like it came from inside you, and names an even more you version of yourself that you intend to become. The vision statement is an opportunity to become even more our authentic selves, by helping us focus on our joy, values, and ability to be of service."
        return lbl
    }()
    
    let backView : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.alpha = 0
        view.layer.zPosition = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewDidLayoutSubviews() {
        self.visionButton.layer.cornerRadius = self.view.frame.width * 0.075
        self.goodBadButton.layer.cornerRadius = self.view.frame.width * 0.075
        self.goodButton.layer.cornerRadius = self.view.frame.width * 0.075
        self.badButton.layer.cornerRadius = self.view.frame.width * 0.075
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MyScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        self.view.addSubview(backView)
        self.view.addSubview(goodButton)
        self.view.addSubview(badButton)
        self.view.addSubview(goodBadButton)
        self.view.addSubview(visionLabel)
        self.view.addSubview(visionButton)
        
        setupLabel()
        setupNavigation()
        setupConstraints()
        setupLblAnimation()
    }
    
    func setupLabel() {
        if visionActive {
            visionLabel.text = vision
            visionButton.setImage(UIImage(named: "visionIcon"), for: .normal)
        } else {
            visionButton.setImage(UIImage(named: "Add"), for: .normal)
            visionLabel.text = "Add your vision statement"
        }
    }
    
    func setupLblAnimation() {
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseIn) {
            self.visionLabel.alpha = 1.0
            self.backView.alpha = 1.0
        } completion: { (nil) in }

    }
    
    func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            
            backView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            backView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            backView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            
            visionButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            visionButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            visionButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            visionButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),

            goodBadButton.topAnchor.constraint(equalTo: self.visionButton.bottomAnchor, constant: 10),
            goodBadButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            goodBadButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            goodBadButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15),

            
            visionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            visionLabel.topAnchor.constraint(equalTo: self.goodButton.bottomAnchor, constant: 10),
            visionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            visionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
                                    
            badButton.topAnchor.constraint(equalTo: self.visionButton.bottomAnchor, constant: 10),
            badButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            badButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            badButton.rightAnchor.constraint(equalTo: self.goodBadButton.leftAnchor, constant: -10),

            goodButton.topAnchor.constraint(equalTo: self.visionButton.bottomAnchor, constant: 10),
            goodButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            goodButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            goodButton.rightAnchor.constraint(equalTo: self.badButton.leftAnchor, constant: -10),
            
        ])
    }
    
    func setupNavigation() {
        
    }
    
    @objc func handleVision(sender: UIButton) {
        print("Test")
        if sender.tag == 0 {
            print("SENDER TAG 0")
            UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn) {
                self.visionLabel.alpha = 0
                self.backView.alpha = 0
            } completion: { (true) in
                self.visionLabel.isHidden = true
                self.backView.isHidden = true
                sender.tag = 1
            }
            return
        }
        print("SENDER TAG 1")
        self.visionLabel.isHidden = false
        self.backView.isHidden = false
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseIn) {
            self.visionLabel.alpha = 1.0
            self.backView.alpha = 1.0
        } completion: { (true) in
            sender.tag = 0
        }
    }
    
    @objc func handleGoodBad(sender: UIButton) {
        if sender.tag == 0 {
            // good
            
        } else if sender.tag == 1 {
            // bad
            
        } else if sender.tag == 2 {  // goodBad, inactive
            UIView.animate(withDuration: 0.5) {
                self.badButton.alpha = 1
                self.goodButton.alpha = 1
            } completion: { (true) in
                sender.tag = 3
            }
        } else if sender.tag == 3 { // goodBad, active
            UIView.animate(withDuration: 0.5) {
                self.badButton.alpha = 0
                self.goodButton.alpha = 0
            } completion: { (true) in
                sender.tag = 2
            }
        }
    }
    
    @objc func handleAddVision() {
        print("Testing vision button!")
        Vision().Settings()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

class Assets {
    static let sharedInstance = Assets()
    let sprites = SKTextureAtlas(named: "Sprites")
    
    func preloadAssets() {
        sprites.preload {
            print("Sprites preloaded")
        }
    }
}
