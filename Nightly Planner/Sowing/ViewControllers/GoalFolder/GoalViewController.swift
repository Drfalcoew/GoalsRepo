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

class GoalViewController: UIViewController, UITextViewDelegate {
    
    let vision = UserDefaults.standard.string(forKey: "vision")
    var toolBar : UIToolbar?
    var originalY : CGFloat?
    var textCountOrder : [Int] = [] // can we do 2 indices?

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
        btn.addTarget(self, action: #selector(handleVision(sender:)), for: .touchUpInside)
        btn.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        return btn
    }()

    let editButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 5
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.alpha = 0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(editVision(sender:)), for: .touchUpInside)
        btn.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        return btn
    }()
    
    let tipsButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("LoA", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.zPosition = 5
        btn.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        btn.layer.borderWidth = 0.25
        btn.tag = 0
        btn.alpha = 0
        btn.layer.borderColor = UIColor.white.cgColor
        btn.addTarget(self, action: #selector(handleTips), for: .touchUpInside)
        btn.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
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
        lbl.isEditable = false
        lbl.layer.zPosition = 1
        lbl.backgroundColor = .clear
        lbl.text = " "
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
        self.editButton.layer.cornerRadius = self.view.frame.width * 0.075
        self.tipsButton.layer.cornerRadius = self.view.frame.width * 0.075
        self.originalY = visionLabel.center.y
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
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
        
        self.view.addSubview(backView)
        self.view.addSubview(editButton)
        self.view.addSubview(visionLabel)
        self.view.addSubview(visionButton)
        self.view.addSubview(tipsButton)
        
        setupKeyboardToolbar()
        setupLabel()
        setupNavigation()
        setupConstraints()
        setupLblAnimation()
    }
    
    func setupKeyboardToolbar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolBar!.barStyle = UIBarStyle.default
        toolBar!.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissKeyboard)) ]
        
        toolBar!.sizeToFit()
    
        visionLabel.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupLabel() {
        
        visionLabel.delegate = self
        if vision?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && vision != nil && vision != ""  {
            visionLabel.text = vision
            editButton.tag = 0
        } else {
            editButton.setTitle("Save", for: .normal)
            visionLabel.isEditable = true
            UserDefaults.standard.setValue(visionLabel.text, forKey: "vision")
            editButton.tag = 1
            visionLabel.text = "Type your one year vision here"
        }
    }
    
    @objc func editVision(sender: UIButton) {
        if sender.tag == 0 { // editing
            sender.setTitle("Save", for: .normal)
            visionLabel.isEditable = true
            visionLabel.isUserInteractionEnabled = true
            sender.tag = 1
        } else {
            // saving
            sender.setTitle("Edit", for: .normal)
            visionLabel.isEditable = false
            visionLabel.isUserInteractionEnabled = false
            UserDefaults.standard.setValue(visionLabel.text, forKey: "vision")
            sender.tag = 0
        }
    }
    
    func setupLblAnimation() {
        UIView.animate(withDuration: 1.5, delay: 1.5, options: .curveEaseIn) {
            self.visionLabel.alpha = 1.0
            self.backView.alpha = 1.0
            self.editButton.alpha = 1.0
            self.tipsButton.alpha = 1.0
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

            editButton.topAnchor.constraint(equalTo: self.visionButton.topAnchor, constant: 0),
            editButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            editButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            editButton.rightAnchor.constraint(equalTo: self.visionButton.leftAnchor, constant: -10),
            
            tipsButton.topAnchor.constraint(equalTo: self.visionButton.topAnchor, constant: 0),
            tipsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            tipsButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15),
            tipsButton.rightAnchor.constraint(equalTo: self.editButton.leftAnchor, constant: -10),

            

            
            visionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            visionLabel.topAnchor.constraint(equalTo: self.visionButton.bottomAnchor, constant: 10),
            visionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95),
            visionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            
            
        ])
    }
    
    @objc func handleTips() {
        let myAlert = UIAlertController(title: "Creation", message: "Write your vision in the present tense, as if it is current in your life today, and read and feel the emotions of it being real every days. Trust your imaginatory faculty. This methodology is taught by Bob Proctor, Neville Goddard, Napoleon Hill, and a few more.", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(myAlert, animated: true, completion: nil)
    }
    
    func setupNavigation() {
        UINavigationController().navigationBar.backItem?.backBarButtonItem?.action = #selector(test)
    }
    
    @objc func test() {

    }
    
    @objc func handleVision(sender: UIButton) {
                
        if sender.tag == 0 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                self.visionLabel.alpha = 0
                self.editButton.alpha = 0
                self.tipsButton.alpha = 0
                self.backView.alpha = 0
            } completion: { (true) in
                self.visionLabel.isHidden = true
                self.backView.isHidden = true
                self.tipsButton.isHidden = true
                sender.tag = 1
            }
            return
        }
        self.visionLabel.isHidden = false
        self.backView.isHidden = false
        self.tipsButton.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            self.visionLabel.alpha = 1.0
            self.editButton.alpha = 1.0
            self.backView.alpha = 1.0
            self.tipsButton.alpha = 1.0
        } completion: { (true) in
            sender.tag = 0
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.count > 90 {
            self.originalY = textView.center.y
            textView.tag = 10
            textView.center.y -= (CGFloat(textView.text.count / 20) * 1.5)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        textCountOrder.append(textView.text.count)
        
        if textCountOrder.count > 2 {
            textCountOrder.remove(at: 0)
        }
        
        if textView.text.count >= 100 {
            textView.tag = 10
            if textView.text.count % 20 == 0 {
                if textCountOrder[0] > textCountOrder[1] {
                    textView.center.y += 30
                } else {
                    textView.center.y -= 30
                }
                
                
                
            }
        } // do text.count / 20 = center.y
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 10 {
            textView.center.y = originalY!
            textView.tag = 0
        }
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
