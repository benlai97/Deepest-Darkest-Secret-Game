//
//  GameViewController.swift
//  Hallow
//
//  Created by Jonathan Chen on 12/3/17.
//  Copyright © 2017 Joyful Bad Juniper. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var player = Character("player")
    var moving = false

    var taps: [(UITouch, Direction)] = []

    override func viewDidLoad() { 
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Olin") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.addChild(self.player)
                
                // Present the scene
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.isMultipleTouchEnabled = true
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = SKScene(fileNamed: "Clocktower") else { return }
    
        
        for touch in touches {

            let position = touch.location(in: scene).x / view.frame.size.width
            let orientation = position < 0.5 ? Direction.left : Direction.right
            
            let tap = (touch, orientation)
            taps.append(tap)
            
            player.walk(taps[0].1)
            
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

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
