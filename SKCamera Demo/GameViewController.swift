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

class GameViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Properties
    
    var demoScene: GameScene!
    let panGesture = UIPanGestureRecognizer()
    let pinchGesture = UIPinchGestureRecognizer()
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // Configure the scene.
        demoScene = GameScene(size: skView.bounds.size)
        demoScene.scaleMode = .resizeFill
        
        // Configure the pan gesture recognizer
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
        
        // Configure the pinch gesture recognizer
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view.addGestureRecognizer(pinchGesture)
        
        // Present the scene.
        skView.presentScene(demoScene)
    }

    // MARK: Touch-based event handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        demoScene.demoCamera.stop()
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let panVelocity = (recognizer.velocity(in: demoScene.view))
        demoScene.demoCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        let pinchVelocity = recognizer.velocity
        demoScene.demoCamera.setCameraScaleVelocity(z: pinchVelocity / 100)
    }
    
    // MARK: Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
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
