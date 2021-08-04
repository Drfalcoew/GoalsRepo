//
//  GameScene.swift
//
//  Created by Drew Foster on 5/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import SpriteKit
import GameplayKit

class MyScene: SKScene {
    
    var cloud_Node : SKSpriteNode?
    
    var node : SKSpriteNode!
    var back_Cloud_Spawn : SKNode!
    var front_Cloud_Spawn : SKNode!
    var topBirdSpawn : SKNode!
    var bottomBirdSpawn : SKNode!
    var tree : SKSpriteNode?
    var bird : SKSpriteNode?
    var birdSmall : SKSpriteNode?

    
    var birdArray = [SKTexture]()
    
    var moveCloudsSequence : SKAction?
    var moveCloudsSequence_1 : SKAction?
    
    
    
    deinit{print("GameScene deinited")}
    
    
    override func didMove(to view: SKView) {
        

        
        setupSprites()
        animateNodes()
    }
    
    func setupSprites() {
        // setup sprites..
        self.tree = childNode(withName: "tree") as? SKSpriteNode
        self.cloud_Node = childNode(withName: "cloud_0") as? SKSpriteNode
        self.back_Cloud_Spawn = childNode(withName: "backClouds")
        self.bird = childNode(withName: "bird") as? SKSpriteNode
        self.birdSmall = childNode(withName: "birdSmall") as? SKSpriteNode
        self.front_Cloud_Spawn = childNode(withName: "frontClouds")
        self.topBirdSpawn = childNode(withName: "topBird")
        self.bottomBirdSpawn = childNode(withName: "bottomBird")
        
        for i in 1...2 {
             let name = "bird_\(i).png"
             self.birdArray.append(Assets.sharedInstance.sprites.textureNamed(name))
         }
    }
    
    func animateNodes() {
        print("ANIMATE NODES")
        let distance = CGFloat(self.frame.width + self.cloud_Node!.frame.width)
        
        // spawn & move front Cloud ------
        let spawnCloud = SKAction.run { self.createFrontCloud() }
        let delay = SKAction.wait(forDuration: 10, withRange: 4)
        let spawnDelay = SKAction.sequence([spawnCloud, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever, withKey: "spawnDelay")
        
        let moveCloud = SKAction.moveTo(x: distance, duration: TimeInterval(0.02 * distance))
        let removeCloud = SKAction.removeFromParent()
        self.moveCloudsSequence = SKAction.sequence([moveCloud, removeCloud])
        
        // spawn & move back Cloud ------
        let spawnCloud_1 = SKAction.run { self.createBackCloud() }
        let delay_1 = SKAction.wait(forDuration: 12, withRange: 4)
        let spawnDelay_1 = SKAction.sequence([spawnCloud_1, delay_1])
        let spawnDelayForever_1 = SKAction.repeatForever(spawnDelay_1)
        self.run(spawnDelayForever_1, withKey: "spawnDelay_1")

        let moveCloud_1 = SKAction.moveTo(x: distance, duration: TimeInterval(0.035 * distance))
        self.moveCloudsSequence_1 = SKAction.sequence([moveCloud_1, removeCloud])

        
        // spawn and move bird ------
                
        let spawnBird = SKAction.run { self.spawnBirds() }
        let delay_Bird = SKAction.wait(forDuration: 20, withRange: 8)
        let spawnDelay_Bird = SKAction.sequence([spawnBird, delay_Bird])
        let spawnDelayForever_Bird = SKAction.repeatForever(spawnDelay_Bird)
        self.run(spawnDelayForever_Bird, withKey: "spawnDelay_Bird")


        
        // move tree in wind
        warpTree(node: tree!)
    }
    
    @objc func createVision() {
        print("TESTER")
        
        UINavigationController().customPush(viewController: CreateVision())
    }
    
    func spawnBirds() {
        let distance = CGFloat(self.frame.width * 1.3)
        
        let moveBird = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.00195 * distance))
        let removeBird = SKAction.removeFromParent()
        let moveAndRemoveBird = SKAction.sequence([moveBird, removeBird])
        
        for i in 0...1 {
            if i == 0 {
                if let x = bird {
                    node = x.copy() as! SKSpriteNode
                    node.run(moveAndRemoveBird)
                    node.run(SKAction.repeatForever(SKAction.animate(with: birdArray, timePerFrame: 0.15)))
                    node.position = topBirdSpawn.position
                    node?.name = "bird"
                    self.addChild(node)
                }
                
            } else {
                if let x = birdSmall {
                    node = x.copy() as! SKSpriteNode
                    node.run(moveAndRemoveBird)
                    node.run(SKAction.repeatForever(SKAction.animate(with: birdArray, timePerFrame: 0.1)))
                    node.position = bottomBirdSpawn.position
                    node?.name = "bird"
                    self.addChild(node)
                }

            }
        }
        
    }
    
    func warpTree(node: SKSpriteNode) {
        
        var warpGrid: SKWarpGeometryGrid?
       var noWarpGrid: SKWarpGeometryGrid?

       // For 2x2 grid - State the source positions
        let sourcePositions: [vector_float2] = [
            vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0),
            vector_float2(0, 0.25), vector_float2(0.5, 0.25), vector_float2(1, 0.25),
            vector_float2(0, 0.5),   vector_float2(0.5, 0.5),   vector_float2(1, 0.5),
            vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1)
        ]

        // For 2x2 grid - State the destination positions
        let destinationPositions: [vector_float2] = [
            vector_float2(0.1, 0),   vector_float2(0.6, 0),   vector_float2(1.1, 0), //bottom
            vector_float2(0, 0.25), vector_float2(0.5, 0.25), vector_float2(1, 0.25), // bot-mid
            vector_float2(0, 0.5),   vector_float2(0.5, 0.5),   vector_float2(1, 0.5), //top-mid
            vector_float2(0.1, 1),   vector_float2(0.6, 1),   vector_float2(1.1, 1), //top
        ]

        //Create the 2x2 warp grid based on the source and destination positions
        warpGrid = SKWarpGeometryGrid(columns: 2, rows: 3,
                                      sourcePositions: sourcePositions,
                                      destinationPositions: destinationPositions)
        
        //Create and assign a Grid to the SKSpritenode that has no warp effects
        //Will be used to convert the trampoline back to original view
        noWarpGrid = SKWarpGeometryGrid(columns: 2, rows: 3)
        node.warpGeometry = noWarpGrid

        //Transform the trampoline grid to show dent
        let transform = SKAction.warp(to: warpGrid!, duration: 1.8)
        //Warp the trampoline gird back to normal
        let transformBack = SKAction.warp(to: noWarpGrid!, duration: 1.8)

        let delay = SKAction.wait(forDuration: 6)

        let transformAction = SKAction.sequence([delay, transform!, transformBack!])
        node.run(SKAction.repeatForever(transformAction))
        node.zPosition = 1
    }
    
    func createRandomCloud() -> SKSpriteNode {
        
        let cloudArray = ["cloud_0", "cloud_1", "cloud_2", "cloud_3"]
        let randomCld = cloudArray.randomElement()
        let selectedTexture = SKTexture(imageNamed: randomCld!)
        let cloud = SKSpriteNode(imageNamed: randomCld!)
        cloud.zPosition = -3
        let body = SKPhysicsBody(texture: selectedTexture, size: selectedTexture.size())
        body.affectedByGravity = false
        body.allowsRotation = false
        body.isDynamic = true
        body.collisionBitMask = 0
        body.restitution = 0
        cloud.physicsBody = body
        addChild(cloud)
        return cloud
    }
    
    func createFrontCloud() {
        let cloud = createRandomCloud()
        let rndNum = randomNum(range: 0...1)
        cloud.zPosition = rndNum != 0 ? -1 : 2
        cloud.alpha = 0.6
        cloud.position = front_Cloud_Spawn.position as CGPoint
        cloud.setScale(((CGFloat(randomNum(range: 8...11))) / 10))
        cloud.run(moveCloudsSequence!, withKey: "move_Front_Clouds")
    }
    
    func createBackCloud() {
        let cloud = createRandomCloud()
        cloud.alpha = 1
        cloud.position = back_Cloud_Spawn.position as CGPoint
        cloud.setScale(((CGFloat(randomNum(range: 4...6))) / 10))
        cloud.run(moveCloudsSequence_1!, withKey: "move_Back_Clouds")
    }
    
    func randomNum(range: ClosedRange<Int> = 1...3) -> Int {
            let min = range.lowerBound
            let max = range.upperBound
            return Int(arc4random_uniform(UInt32(1 + max - min))) + min
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
