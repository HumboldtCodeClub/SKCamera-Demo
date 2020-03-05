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

class GameScene: SKScene {
    
    // MARK: Properties
    
    // The game layer node holds our demo game objects.
    // In a typical game this might be called backgroundLayer to hold all the background nodes,
    // or enemyLayer to hold all of the enemy sprite nodes, these types of SKNodes are used to keep the
    // game objects organized and easier to work with.
    let gameLayer: SKNode!
    
    // The whole point of this project is to demonstrate our SKCameraNode subclass!
    let demoCamera: DemoCamera!
    
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
        addGamePieces()
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // Update the camera each frame
        demoCamera.update()
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
