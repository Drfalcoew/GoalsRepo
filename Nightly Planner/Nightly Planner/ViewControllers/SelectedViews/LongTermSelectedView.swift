//
//  LongTermSelectedView.swift
//  Nightly Planner
//
//  Created by Drew Foster on 1/23/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class LongTermSelectedView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GADInterstitialDelegate {
    
    let cellId = "cellId"
    var x : CGFloat?
    var progressBackgroundViewHeight : NSLayoutConstraint?
    var adView : GADInterstitial!
    var collectionView : UICollectionView!


    let goalCategoryIcon : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryViewBackground : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = CGFloat(2)
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor(r: 40, g: 43, b: 53)
        return view
    }()
    
    let progressBackgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 125, g: 200, b: 180)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        interstitialAd()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parent?.title = "Short Term Goal"

        
        
        setupViews()
        setupCollectionView()
        setupConstraints()
    }
    
    func interstitialAd() {
        var adCount = UserDefaults.standard.integer(forKey: "ad")
        adCount = adCount + 1
        UserDefaults.standard.set(adCount, forKey: "ad")
        UserDefaults.standard.synchronize()
        print(adCount)
        
        if adCount % 10 == 0 { // every 5 page turns, open an ad
            //show ad
            //showAd()
        }
    }
    
    func showAd() {
        adView = GADInterstitial(adUnitID: "ca-app-pub-8752347849222491/1365265751")
        adView.load(GADRequest())
        adView.delegate = self
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if adView.isReady {
            adView.present(fromRootViewController: self)
            
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 2 - 15), height: (view.frame.width / 2 - 12))
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 6
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.layer.zPosition = 2
        
        collectionView.register(LTSVCOne.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LTSVCOne
        cell.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
        
        switch indexPath.row {
        case 0:
            cell.customImageView.image = UIImage(named: "icon_\(x)")
            cell.customImageView.tintImageColor(color: .white)
        default:
            break
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.height / 3)
    }
    
}
