//
//  Player.swift
//  Hallow
//
//  Created by Jonathan Chen on 12/3/17.
//  Copyright © 2017 Joyful Bad Juniper. All rights reserved.
//

import SpriteKit

enum Direction {
    case left, right
}



class Character: SKSpriteNode {
    
    static let playerCollisionMask: UInt32 = 1

    let prefix: String
    var orientation: Direction = .right
    var jumping = false
    
    let spotlight = SKLightNode()

    init(_ prefix: String) {
        self.prefix = prefix
        
        let texture = SKTexture(imageNamed: "\(prefix)_stand")
       
        super.init(texture: texture, color: .gray, size: texture.size())
        
        self.zPosition = 5
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width * 0.7,
                                                             height: self.size.height))
        self.physicsBody?.collisionBitMask = Character.playerCollisionMask | Level.wallCollisionMask
        self.physicsBody?.categoryBitMask = Character.playerCollisionMask
        
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.restitution = 0
        
        spotlight.position = position
        
        self.addChild(spotlight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.prefix = "player"
        super.init(coder: aDecoder)
    }
    
    func stand() {
        self.texture = SKTexture(imageNamed: "\(prefix)_stand")
        removeAction(forKey: "move")
        removeAction(forKey: "spotmove")
    }
    
    func jump() {
        if (!jumping && physicsBody?.velocity.dy == 0) {
            print("jumping")
            
            texture = SKTexture(imageNamed: "\(prefix)_jump")
            
            let moveUp = SKAction.moveBy(x: 0, y: 150, duration: 0.25)

            jumping = true

            run(moveUp) {
                self.jumping = false
            }
            
            spotlight.run(moveUp)
        }
    }
    
    func walk(_ direction: Direction) {
        
        print("walking \(direction == .left ? "left" : "right")")
        
        let walkingFrames = [
            SKTexture(imageNamed: "\(prefix)_walk1"),
            SKTexture(imageNamed: "\(prefix)_walk2")
        ]

        let walkAnimation = SKAction.repeat(SKAction.animate(with: walkingFrames, timePerFrame: 1/4), count: 2)
        
        let moveLeft = SKAction.moveBy(x: -200, y: 0, duration: walkAnimation.duration)
        let moveRight = SKAction.moveBy(x: 200, y: 0, duration: walkAnimation.duration)

        let walkAndMoveRight = SKAction.group([walkAnimation, moveRight])
        let walkAndMoveLeft = SKAction.group([walkAnimation, moveLeft])
        
        face(direction)
        
        if (orientation == .left) {
            run(SKAction.repeatForever(walkAndMoveLeft), withKey: "move")
            spotlight.run(SKAction.repeatForever(walkAndMoveLeft), withKey: "spotmove")
        } else if (orientation == .right) {
            run(SKAction.repeatForever(walkAndMoveRight), withKey: "move")
            spotlight.run(SKAction.repeatForever(walkAndMoveRight), withKey: "spotmove")
        }
    }

    private func face(_ direction: Direction) {
        guard orientation != direction else { return }
        
        orientation = direction
        
        let faceLeft = SKAction.scaleX(to: -1, y:1, duration:0.0)
        let faceRight = SKAction.scaleX(to: 1,  y:1, duration:0.0)
        
        switch (direction) {
        case .left: run(faceLeft)
        case .right: run(faceRight)
        }
    }
}
