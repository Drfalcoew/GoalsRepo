//
//  SortView.swift
//  Nightly Planner
//
//  Created by Drew Foster on 2/14/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//


import UIKit
import Firebase

class SortView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var topViewHeightAnchor: NSLayoutConstraint?
    var blackInfoView = UIView()
    let cellId : String = "Cell0"
    let cellIdOne : String = "Cell1"
    
    //let loginView = LoginController()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(r: 75, g: 115, b: 148)
        return cv
    }()
    
    
    
    
    func infoView(){
        
        if let window = UIApplication.shared.keyWindow {
            blackInfoView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
            
            window.addSubview(blackInfoView)
            window.addSubview(collectionView)
            
            collectionView.frame = CGRect(x: 0, y: -(window.frame.height / 4), width: window.frame.width, height: window.frame.height / 4)
            collectionView.layer.cornerRadius = 5
            
            
            blackInfoView.frame = window.frame
            blackInfoView.alpha = 0
            
            blackInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.5) {
                self.collectionView.center.y = 0 + self.collectionView.frame.height / 2
                self.blackInfoView.alpha = 1
            }
        }
    }
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5) {
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.center.y = -(window.frame.height / 2)
            } else {
                self.collectionView.alpha = 0
            }
            self.blackInfoView.alpha = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.autoresizesSubviews = true
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdOne, for: indexPath)
            cell.addSubview(bannerAdController().view)
        }
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var x : CGFloat
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height / 4)
        } else {
            if let window = UIApplication.shared.keyWindow {
                if (window.frame.height <= 400){
                    x = 32
                } else if (window.frame.height > 400 && window.frame.height <= 720) {
                    x = 50
                } else {
                    x = 90
                }
            } else {
                x = collectionView.frame.height / 4
            }
            return CGSize(width: collectionView.frame.width, height: x)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            handleDismiss()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "feedbackHandler"), object: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
    override init() {
        super.init()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(infoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(bannerAdCellContent.self, forCellWithReuseIdentifier: cellIdOne)
    }
}

