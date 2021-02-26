//
//  GameScene.swift
//  testing
//
//  Created by Drew Foster on 5/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import SpriteKit
import GameplayKit

class MyScene: SKScene {
    
    var cloud_0 : SKSpriteNode?
    var topTree : SKNode?
    var bottomTree : SKNode?
    var anchor = CGPoint(x: 100, y: 100)
    var fixedJoint : SKPhysicsJointSpring?
    
    var moveCloudsAction : SKAction?
    
    override func didMove(to view: SKView) {
        print("TESTING")
    
    
    //fixedJoint = SKPhysicsJointFixed.joint(withBodyA: topTree!, bodyB: bottomTree!, anchor: CGPoint(x: 100, y: 100))
        
        self.scene?.physicsWorld.add(fixedJoint!)
        
        setupSprites()
        animateNodes()
    }
    
    func setupSprites() {
        cloud_0 = childNode(withName: "cloud_0") as? SKSpriteNode
        moveCloudsAction = SKAction.move(by: CGVector(dx: 200.0, dy: 0), duration: 30)
        print("inside SETUPSPRITES()")
    }
    
    func animateNodes() {
        cloud_0!.run(moveCloudsAction!) {
            print("COMPLETED")
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
