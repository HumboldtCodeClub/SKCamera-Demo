//
//  GameViewController.swift
//  SKCamera Demo
//
//  Created by Sean Allen on 3/29/18.
//  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: Properties
    
    var scene: GameScene!
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        
        // Present the scene.
        skView.presentScene(scene)
    }

    // MARK: View Controller Configuration
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
