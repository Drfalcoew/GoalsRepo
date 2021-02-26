//
//  showMenu.swift
//  Nightly Planner
//
//  Created by Hand Of The King on 2/19/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit

class ShowMenu: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    let titleText : [String] = ["Home", "Goals", "Profile", "Settings"]
    let cellId = "cellId"
    let blackView = UIView()
    var viewController : UIViewController?
    let vc : [UIViewController] = [ViewController(), GoalViewController(), ProfileViewController()]
    var tap : UITapGestureRecognizer?
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.masksToBounds = true
        cv.layer.zPosition = 2
        cv.alpha = 1.0
        return cv
    }()
    
    let menuView : UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.layer.zPosition = 1
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    let settingsView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        view.layer.zPosition = 2
        return view
    }()
    
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_3")
        img.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        return img
    }()
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Settings"
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    @objc func Settings() {
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(menuView)
            menuView.addSubview(collectionView)
            menuView.addSubview(settingsView)
            
            
            let x = window.frame.width / -2.5
            let y = UIApplication.shared.statusBarFrame.height
            self.blackView.frame = window.frame
            self.menuView.frame = CGRect(x: x - 5, y: y, width: window.frame.width / 2.5, height: window.frame.height)
            
            setupConstraints()

            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSettings)))
           
            UIView.animate(withDuration: 0.35, delay: 0.01, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.menuView.frame = CGRect(x: 0, y: y, width: window.frame.width / 2.5, height: window.frame.height)
                self.menuView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc func dismissSettings() {
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -2.5
            let y = UIApplication.shared.statusBarFrame.height
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height)
            }) { (true) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    
    override init() {
        super.init()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(settingsHandler))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        tap?.delegate = self
        
        settingsView.addGestureRecognizer(tap!)
        settingsView.addSubview(image)
        settingsView.addSubview(title)
        
        setupCollectionView()
    }
    
    @objc func settingsHandler() {
        print("Settings button touched")
        
        title.textColor = UIColor(r: 75, g: 80, b: 120)
        image.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
        
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -2.5
            let y = UIApplication.shared.statusBarFrame.height
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height)
            }) { (completed: Bool) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
                self.viewController?.navigationController?.customPush(viewController: SettingsViewController())
                self.title.textColor = UIColor(r: 75, g: 80, b: 120)
                self.image.tintImageColor(color: UIColor(r: 75, g: 80, b: 120))
            }
        }
    }
    
    func setupConstraints() {
        settingsView.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: -60).isActive = true
        settingsView.widthAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 0.95).isActive = true
        settingsView.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor, constant: 0).isActive = true
        settingsView.heightAnchor.constraint(equalTo: self.collectionView.heightAnchor, multiplier: 0.1).isActive = true
        
        
        collectionView.widthAnchor.constraint(equalTo: menuView.widthAnchor, multiplier: 1).isActive = true
        collectionView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: menuView.centerXAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: settingsView.topAnchor, constant: -10).isActive = true
        
        image.leftAnchor.constraint(equalTo: self.settingsView.leftAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalTo: self.settingsView.heightAnchor, multiplier: 1/2.5).isActive = true
        image.heightAnchor.constraint(equalTo: self.settingsView.heightAnchor, multiplier: 1/2.5).isActive = true
        image.centerYAnchor.constraint(equalTo: self.settingsView.centerYAnchor, constant: 0).isActive = true
        
        title.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: self.settingsView.rightAnchor, constant: -10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.settingsView.centerYAnchor, constant: 0).isActive = true
        title.heightAnchor.constraint(equalTo: self.settingsView.heightAnchor, multiplier: 3/5).isActive = true
    }
    
    func setupCollectionView() {
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height * 0.15) // Header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -2.5
            let y = UIApplication.shared.statusBarFrame.height
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height)
            }) { (completed: Bool) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
                if self.viewController?.view.tag != indexPath.row {
                    self.viewController?.navigationController?.customPush(viewController: self.vc[indexPath.row])
                }
            }
        } else {
            print("IN ELSE, KEY WINDOW NIL")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        //cell.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        cell.image.image = UIImage(named: "tab_\(indexPath.row)")
        cell.title.text = titleText[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width * 0.95, height: collectionView.frame.size.height * 0.1)
    }
    
    
}
