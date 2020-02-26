//
//  InterstitialAd.swift
//  Nightly Planner
//
//  Created by Drew Foster on 2/22/19.
//  Copyright © 2019 Drew Foster. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterstitialAd : UIViewController, GADInterstitialDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAd() {
        interstitialAd = GADInterstitial(adUnitID: "ca-app-pub-8752347849222491/1365265751")
        interstitialAd.load(GADRequest())
        interstitialAd.delegate = self
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if interstitialAd.isReady {
            interstitialAd.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    var interstitialAd: GADInterstitial!
    
    
}
