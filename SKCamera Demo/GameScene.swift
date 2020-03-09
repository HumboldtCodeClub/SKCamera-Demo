//
///  GameScene.swift
///  SKCamera Demo
//
//  In any scene implementing the demo camera you will need to:
//    1. Configure the camers
//    2. Set the scene's camera to the demo camera instance
//    3. Add the camera node as a child of the scene (so HUD can be displayed)
//    4. Call the camera's update function from the scene's update function
//
///  Created by Sean Allen on 3/29/18.
///  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    // The game layer node holds our demo game objects.
    // In a typical game this might be called backgroundLayer to hold all the background nodes,
    // or enemyLayer to hold all of the enemy sprite nodes, these types of SKNodes are used to keep the
    // game objects organized and easier to work with.
    let gameLayer: SKNode!
    
    // The whole point of this project is to demonstrate our SKCameraNode subclass!
    let demoCamera: DemoCamera!
    
    var initialScale: CGFloat = 1.0
    
    // MARK: Initializers
    
    // Init
    override init(size: CGSize) {
        
        // Initialize the game layer node that will hold our game pieces and
        // move the gameLayer node to the center of the scene
        gameLayer = SKNode()
        gameLayer.position = CGPoint(x: 0, y: 0)
        
        // Initailize the demo camera
        demoCamera = DemoCamera()
        demoCamera.showScale()
        demoCamera.showPosition()
        demoCamera.showViewport()
        
        // Call the super class initializer
        super.init(size: size)
        
        // Set the scene's camera
        // If you do not add the camera as a child of the scene panning and zooming will still work,
        // but none of the children of the camera will be rendered. So, no HUD or game controls.
        addChild(demoCamera)
        camera = demoCamera
        
        // Add the game layer node to the scene
        addChild(gameLayer)
    }
    
    // When not using an .sks file to build our scenes, we must have this method
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    // MARK: Scene Lifecycle
    
    override func didMove(to view: SKView) {
        // Call any custom code to setup the scene
        
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handlePanGesture(recognizer:)))
        panGesture.delegate = self
        self.view!.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(handlePinchGesture(recognizer:)))
        self.view!.addGestureRecognizer(pinchGesture)
        
        addGamePieces()
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // Update the camera each frame
        demoCamera.update()
    }
    
    // MARK: Touch-based event handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        demoCamera.stop()
    }
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        // While user interaction is happening simply apply thier changes directly to the camera
        // Translation must be multiplied by scale to keep a consistent motion at all levels
        let translation = recognizer.translation(in: self.view)
        demoCamera.position = CGPoint(x: demoCamera.position.x - (translation.x * demoCamera.xScale),
                                      y: demoCamera.position.y + (translation.y * demoCamera.yScale))
        
        // reset the translation so that next cycle we get the delta from our new position
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        // Once user interaction ends set camera's velocity so it can continue to move and slow to a stop
        if (recognizer.state == .ended) {
            let panVelocity = (recognizer.velocity(in: view))
            demoCamera.setCameraPositionVelocity(x: panVelocity.x / 100, y: panVelocity.y / 100)
        }
    }
    
    @objc func handlePinchGesture(recognizer: UIPinchGestureRecognizer) {
        // Update the camera's scale velocity based on user interaction.
        // Recognizer velocity is reduced to provide a more pleasant user experience.
        // Increase or decrease the divisor to create a faster or slower camera.
        if (recognizer.state == .began) {
            print("Initial Scale: \(initialScale)")
//            initialScale = demoCamera.xScale
        }
        
        if (recognizer.state == .changed) {
//            var newScale = initialScale * recognizer.scale
//            newScale = newScale < demoCamera.range.z.min ? demoCamera.range.z.min : newScale
//            newScale = newScale > demoCamera.range.z.max ? demoCamera.range.z.max : newScale
//            demoCamera.setScale(newScale)
//            print("New Scale = \(initialScale) * \(recognizer.scale) = \(newScale)")
            
            // Second attempt
            let deltaScale = recognizer.scale - 1.0;
            var scaleMultiplier = 1.0 - deltaScale;
            if (demoCamera.xScale < demoCamera.range.z.min ||
                demoCamera.xScale > demoCamera.range.z.max) {
                scaleMultiplier = 1.0
            }
            demoCamera.setScale(demoCamera.xScale * scaleMultiplier)
            if (demoCamera.xScale < demoCamera.range.z.min) {
                demoCamera.setScale(demoCamera.range.z.min)
            }
            if (demoCamera.xScale > demoCamera.range.z.max) {
                demoCamera.setScale(demoCamera.range.z.max)
            }
            recognizer.scale = 1.0
        }

        if (recognizer.state == .ended) {
//            initialScale = demoCamera.xScale
            demoCamera.setCameraScaleVelocity(z: recognizer.velocity / 100)
            print("Final Scale = \(demoCamera.xScale)")
        }
        
    }
    
    // MARK: Gesture Recognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Since this demo only configures two gesture recognizers and we want them to work simultaneously we only need to return true.
        // If additional gesture recognizers are added there could be a need to add aditional logic here to setup which specific
        // recognizers should be working together.
        return true;
    }
    
    
    // MARK: Private Functions
    
    // This function just sets up a bunch of shape nodes so we can demonstrate the camera panning and zooming.
    private func addGamePieces() {
        // Keeping column and row numbers even will keep the game centered about the origin because we're working with integers
        let columns = 18
        let rows = 18
        for column in 0...columns - 1 {
            for row in 0...rows - 1 {
                let newGamePiece = SKShapeNode(circleOfRadius: 50.0)
                newGamePiece.position = CGPoint(x: (column * 120) - (columns * 60) + 60, y: (row * 120) - (rows * 60) + 60)
                newGamePiece.strokeColor = UIColor.blue
                newGamePiece.fillColor = UIColor.blue
                gameLayer.addChild(newGamePiece)
            }
        }
        let centerGamePiece = SKShapeNode(circleOfRadius: 5.0)
        centerGamePiece.strokeColor = .red
        centerGamePiece.fillColor = .red
        centerGamePiece.position = CGPoint(x: 0, y: 0)
        gameLayer.addChild(centerGamePiece)
    
    }
}
