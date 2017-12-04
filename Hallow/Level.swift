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
            
            let halfWidth = CGFloat(fg.numberOfColumns) / 2.0 * size.width
            let halfHeight = CGFloat(fg.numberOfRows) / 2.0 * size.height
            
            for row in 0..<fg.numberOfRows {
                for col in 0..<fg.numberOfColumns {
                    
                    let tile = fg.tileDefinition(atColumn: col, row: row)
                    
                    if let isEdge = tile?.userData?["edge"] as? Bool {
                        if (isEdge) {
                            let x = CGFloat(col) * size.width - halfWidth
                            let y = CGFloat(row) * size.height - halfHeight
                            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                            
                            let node = SKShapeNode(rect: rect)
                            
                            node.position = CGPoint(x: x, y: y)
                            node.physicsBody = SKPhysicsBody.init(rectangleOf: size, center: CGPoint(x: size.width / 2.0, y: size.height / 2.0))
                            node.physicsBody?.isDynamic = false
                            node.physicsBody?.collisionBitMask = Character.playerCollisionMask | Level.wallCollisionMask
                            node.physicsBody?.categoryBitMask = Level.wallCollisionMask
                            fg.addChild(node)
                        }
                    }
                }
            }
        }
    }
    
}
