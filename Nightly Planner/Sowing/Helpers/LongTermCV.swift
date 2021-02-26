//
//  longTermCollectionViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/2/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class LongTermCV: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var longTermIcons : [Int] = []
    var iconInt: Int?
    var cellId : String = "cellId"
    
    
    var collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        
        return view
    }()
    
    
    
    override func viewDidLoad() {
        
        self.view.addSubview(collectionView)
        
        setupConstraints()
        setupCollectionView()
    }
    
    
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.height / 2) / 3 * 0.6, height: (view.frame.height / 2) / 3 * 0.6)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(imageCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupConstraints() {
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.longTermIcons.isEmpty == false {
            return 27 - self.longTermIcons.count
        } else {
            print("FUCK YOU!!!")
            return 27
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        iconInt = indexPath.row
        UserDefaults.standard.set(iconInt, forKey: "iconInt")
        print(iconInt ?? "No value")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = 50
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! imageCollectionViewCell
        
        cell.alpha = 0

        
        cell.goalCategoryIcon.image = UIImage(named: "\(indexPath.row)")
        cell.goalCategoryIcon.tintImageColor(color: .black)
        
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                cell.alpha = 1
            })
        }

        
        return cell
    }
    
}
