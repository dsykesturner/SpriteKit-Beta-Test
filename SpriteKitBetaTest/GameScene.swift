//
//  GameScene.swift
//  SpriteKitBetaTest
//
//  Created by Daniel Sykes-Turner on 30/7/19.
//  Copyright © 2019 Daniel Sykes-Turner. All rights reserved.
//

import SpriteKit
import GameplayKit

struct pc {
    static let none: UInt32     = 0x1 << 0
    static let ball: UInt32     = 0x1 << 1
    static let house: UInt32    = 0x1 << 2
}

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // Setup the contact delegate
        self.physicsWorld.contactDelegate = self
        
        // Create a sprite node to interact with the shape node
        let width = 100.0
        let height = 132.0
        let texture = SKTexture(imageNamed: "house")
        let houseNode = SKSpriteNode(texture: texture)
        houseNode.position = CGPoint(x: self.size.width/2, y: CGFloat(height/2))
        houseNode.size = CGSize(width: width, height: height)
        houseNode.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.3, size: texture.size())
        houseNode.physicsBody?.isDynamic = false
        houseNode.physicsBody?.categoryBitMask = pc.house
        houseNode.physicsBody?.collisionBitMask = pc.none
        
        addChild(houseNode)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
        let ball = SKShapeNode(circleOfRadius: 25)
        ball.position = CGPoint(x: self.size.width/2, y: self.size.width/2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        ball.physicsBody?.categoryBitMask = pc.ball
        ball.physicsBody?.collisionBitMask = pc.house
        ball.physicsBody?.contactTestBitMask = pc.house
        
        addChild(ball)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact between \(contact.bodyA.node!) and \(contact.bodyB.node!)")
    }
}
