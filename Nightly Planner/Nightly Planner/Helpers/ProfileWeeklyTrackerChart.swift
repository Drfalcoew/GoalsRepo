//
//  ProfileWeeklyTrackerChart.swift
//  Nightly Planner
//
//  Created by Drew Foster on 9/9/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class ProfileWeeklyTrackerChart: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var longTermIcons : [Int] = []
    var iconInt: Int?
    var cellId : String = "cellId"
    
    var weeklyChart : [CGFloat] = [1, 1, 1, 1, 1, 1, 1]
    
    var chartCollectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        
        return view
    }()
    
    var view : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 221, g: 221, b: 221)
        view.alpha = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(chartCollectionView)
        self.chartCollectionView.addSubview(view)
        
        
        setupConstraints()
        setupCollectionView()
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    func setupCollectionView() {
        var x : CGFloat
        var y : CGFloat
        var z : CGFloat
        var a : CGFloat
        if let window = UIApplication.shared.keyWindow {
            x = window.frame.width / 11.7
            y = window.frame.width * 0.02
            z = window.frame.height * 0.03
            a = window.frame.height * 0.203
        } else {
            x = 60
            y = 20
            z = 30
            a = 200
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: x, height: a)
        //layout.itemSize.width = CGFloat(view.frame.width / 14)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = y
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: z, right: 0)
        
        chartCollectionView.collectionViewLayout = layout
        chartCollectionView.backgroundColor = .clear
        chartCollectionView.delegate = self
        chartCollectionView.dataSource = self
        chartCollectionView.register(WeeklyChartCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    func setupConstraints() {
        chartCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        chartCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        chartCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
        chartCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        view.centerXAnchor.constraint(equalTo: self.chartCollectionView.centerXAnchor, constant: 0).isActive = true
        view.centerYAnchor.constraint(equalTo: self.chartCollectionView.centerYAnchor, constant: 0).isActive = true
        view.widthAnchor.constraint(equalTo: self.chartCollectionView.widthAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7 // days of the week
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeeklyChartCell
        
        cell.alpha = 1
        cell.barHeightConstraint?.constant = 1
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5, animations: {
                cell.barView.transform = CGAffineTransform(scaleX: 1, y: self.weeklyChart[indexPath.item])             //
                print("TESTING \(self.weeklyChart[indexPath.item])")
                cell.alpha = 1
            })
        }
        
        
        return cell
    }
    
    
}
