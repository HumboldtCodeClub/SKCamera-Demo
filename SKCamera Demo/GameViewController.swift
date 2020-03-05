//
//  GameViewController.swift
//  SKCamera Demo
//
//  This demo application implements the gesture recognizers which manipulate the demo camera in the view controller.
//  The purpose is for compatibility in universal applications.  Universal apps can share a single scene and will have
//  a separate view controller for each target platform.
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
        // use stop to give the effect of pinning the camera under your finger when touching the screen.
        demoScene.demoCamera.stop()
//        demoScene.demoCamera.isUnderUserControl = true
//        let touch = touches.first!
//        let location = touch.location(in: demoScene)
//        let move: SKAction = SKAction.move(to: location, duration: 0.5)
//        move.timingMode = .easeOut
//        demoScene.demoCamera.run(move)
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        demoScene.demoCamera.position = CGPoint(x: demoScene.demoCamera.position.x - translation.x,
                                                y: demoScene.demoCamera.position.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        if (recognizer.state == .ended) {
            let panVelocity = (recognizer.velocity(in: demoScene.view))
            demoScene.demoCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
        }
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        // Update the camera's scale velocity based on user interaction.
        // Recognizer velocity is reduced to provide a more pleasant user experience.
        // Increase or decrease the divisor to create a faster or slower camera.
//        if (recognizer.state == .changed) {
//            demoScene.demoCamera.isCameraInMotion = true
//            demoScene.demoCamera.isUnderUserControl = true
//            let pinchVelocity = recognizer.velocity
//            demoScene.demoCamera.setCameraScaleVelocity(z: pinchVelocity / 100)
//        }
//
//        if (recognizer.state == .ended) {
//            demoScene.demoCamera.isUnderUserControl = false;
//        }
        
    }
    
    // MARK: Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Since this demo only configures two gesture recognizers and we want them to work simultaneously we only need to return true.
        // If additional gesture recognizers are added there could be a need to add aditional logic here to setup which specific
        // recognizers should be working together.
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
