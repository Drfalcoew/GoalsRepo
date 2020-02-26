//
//  imageCollectionViewController.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/26/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class imageCollectionViewController: UICollectionViewController {
    
    
    let cellId = "cellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        collectionView.register(imageCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 29
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! imageCollectionViewCell
        
        for i in 0...28 {
            cell.goalCategoryIcon.image = UIImage(named: "icon_\(i)")
        }

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width / 4)
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(indexPath.row, forKey: "categoryIcon")
    }
    
}

