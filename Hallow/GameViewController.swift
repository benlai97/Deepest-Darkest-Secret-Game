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
    


    var taps: [(UITouch, Direction)] = []

    override func viewDidLoad() { 
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Clocktower") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.isMultipleTouchEnabled = true
        }
        
        changeScene(to: "Olin")
    }
    
    func changeScene(to fileNamed: String) {
        let transition = SKTransition.fade(withDuration: 3.0)

        if let nextScene = SKScene(fileNamed: fileNamed), let view = view as? SKView {
            nextScene.scaleMode = .aspectFill
            view.presentScene(nextScene, transition: transition)
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
