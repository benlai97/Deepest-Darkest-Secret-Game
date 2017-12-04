//
//  Clocktower.swift
//  Hallow
//
//  Created by Jonathan Chen on 12/3/17.
//  Copyright © 2017 Joyful Bad Juniper. All rights reserved.
//

import SpriteKit

class Level: SKScene {
    
    static let wallCollisionMask: UInt32 = 2
    
    
    var player = Character("player")

    var taps: [(UITouch, Direction)] = []
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.9)
        
        if let scene = scene {
            scene.addChild(self.player)
            
            if let fg = scene.childNode(withName: "fg") {
                self.physicsBody = SKPhysicsBody(edgeLoopFrom: fg.frame)
            }
            
            let camera = SKCameraNode()
            self.camera = camera
            scene.addChild(camera)
        }
        
        loadGround()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if let camera = camera {
            camera.position = player.position
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = SKScene(fileNamed: "Clocktower") else { return }

        for touch in touches {
            
            if let view = view {
                let position = touch.location(in: scene).x / view.frame.size.width
                let orientation = position < 0.5 ? Direction.left : Direction.right
                
                let tap = (touch, orientation)
                taps.append(tap)
                player.walk(taps[0].1)
            }
        }
        
        if taps.count > 1 {
            player.jump()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            taps = taps.filter { return $0.0 != touch }
        }
        
        if taps.count > 0 {
            player.walk(taps[0].1)
        } else {
            player.stand()
        }
        
    }
    
    private func loadGround() {
        if let fg = self.childNode(withName: "fg") as? SKTileMapNode {
            
            let size = fg.tileSize
            let tW = size.width
            let tH = size.height
            
            let halfWidth = size.width * 0.5 * CGFloat(fg.numberOfColumns)
            let halfHeight = size.height * 0.5 * CGFloat(fg.numberOfRows)
            
            for row in 0..<fg.numberOfRows {
                for col in 0..<fg.numberOfColumns {
                    
                    if let tile = fg.tileDefinition(atColumn: col, row: row) {
                        if let isEdge = tile.userData?["edge"] as? Bool {
                            if (isEdge) {
                                
                                let x = CGFloat(col) * tW - halfWidth
                                let y = CGFloat(row) * tH - halfHeight
                                
                                print(x, y)
                                
                                let rect = CGRect(x: 0, y: 0, width: tW, height: tH)
                                
                                let node = SKShapeNode(rect: rect)
                                
                                node.position = CGPoint(x: x, y: y)
                                
                                print(size)
                                
                                node.physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x: tW / 2, y: tH / 2))
                                node.physicsBody?.isDynamic = false
                                node.physicsBody?.collisionBitMask = Character.playerCollisionMask | Level.wallCollisionMask
                                node.physicsBody?.categoryBitMask = Level.wallCollisionMask
                                node.physicsBody?.restitution = 0
                                
                                fg.addChild(node)
                            }
                        }
                    }
                }
            }
        }
    }
}
