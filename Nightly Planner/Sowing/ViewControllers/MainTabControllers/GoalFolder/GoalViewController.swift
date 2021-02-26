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
