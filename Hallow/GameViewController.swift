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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.isMultipleTouchEnabled = true
        }
    }
    
    func move(x: CGFloat) {
        if let scene = SKScene(fileNamed: "GameScene") {
            print("moving \(x < 0 ? "left" : "right")")
            
            let ground = scene.childNode(withName: "CT Ground")
            ground?.position.x -= x
            
            let bg = scene.childNode(withName: "CT Background")
            bg?.position.x -= x * 0.5
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.count > 1) { // jump
            print("jump")
        } else { // move
            guard let scene = SKScene(fileNamed: "GameScene") else { return }
            guard let touch = touches.first?.location(in: scene) else { return }
            
            let x = touch.x / scene.size.width
            
            if (x < 0.5) {
                move(x: -5)
            } else {
                move(x: 5)
            }

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
