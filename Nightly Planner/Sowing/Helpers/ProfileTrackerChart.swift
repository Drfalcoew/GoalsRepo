//
//  ProfileWeeklyTrackerChart.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/9/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class ProfileTrackerChart: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    

    var longTermIcons : [Int] = []
    var iconInt: Int?
    var cellId : String = "cellId"
    
    var collectionView : UICollectionView!
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    override func layoutSubviews() {
        setupCollectionView()
        setupConstraints()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.frame.width / 4), height: (self.frame.height))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.isPagingEnabled = false
        collectionView.layer.zPosition = 2
        
        collectionView.register(ProfileChartCell.self, forCellWithReuseIdentifier: cellId)
        self.addSubview(collectionView)

    }
    
    
    func setupConstraints() {
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4 // number of goal types
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let completed : CGFloat
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileChartCell
        cell.backgroundColor = .clear
        cell.image.image = UIImage(named: "goalType_\(indexPath.row)")
        cell.bgView.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        return cell
   
    }
    
}
