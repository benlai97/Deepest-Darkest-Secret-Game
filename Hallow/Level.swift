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

    override func didMove(to view: SKView) {
        if let fg = self.childNode(withName: "fg") as? SKTileMapNode {
            
            let size = fg.tileSize
            let tW = size.width
            let tH = size.height
           
            for row in 0..<fg.numberOfRows {
                for col in 0..<fg.numberOfColumns {
                    
                    if let tile = fg.tileDefinition(atColumn: col, row: row) {
                        if let isEdge = tile.userData?["edge"] as? Bool {
                            if (isEdge) {
                                
                                let x = CGFloat(col) * tW
                                let y = CGFloat(row) * tH
                                
                                print(x, y)
                                
                                let rect = CGRect(x: x, y: y, width: tW, height: tH)

                                let node = SKShapeNode(rect: rect)
                                
                                print(size)
                                
                                node.physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x: tW / 2, y: tH / 2))
                                node.physicsBody?.isDynamic = false
                                node.physicsBody?.pinned = true
                                node.physicsBody?.collisionBitMask = Character.playerCollisionMask | Level.wallCollisionMask
                                node.physicsBody?.categoryBitMask = Level.wallCollisionMask
                                
                                fg.addChild(node)
                                
                                //                            let x = CGFloat(col) * size.width - halfWidth
                                //                            let y = CGFloat(row) * size.height - halfHeight
                                //                            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                                //
                                //                            let node = SKShapeNode(rect: rect)
                                //
                                //                            node.position = CGPoint(x: x, y: y)
                                //                            node.physicsBody =
                                //                            node.physicsBody?.isDynamic = false
                                //                            node.physicsBody?.collisionBitMask = Character.playerCollisionMask | Level.wallCollisionMask
                                //                            node.physicsBody?.categoryBitMask = Level.wallCollisionMask
                                //                            fg.addChild(node)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
