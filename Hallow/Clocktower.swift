//
//  Clocktower.swift
//  Hallow
//
//  Created by Jonathan Chen on 12/3/17.
//  Copyright © 2017 Joyful Bad Juniper. All rights reserved.
//
import SpriteKit

class Clocktower: Level {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        let frameWidth = view?.frame.width
        if (abs(player.position.x) >= (frameWidth!+300)) {
            gameView?.changeScene(to: "Olin")
        }
    }
}
