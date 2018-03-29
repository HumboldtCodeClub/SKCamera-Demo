//
//  GameScene.swift
//  SKCamera Demo
//
//  Created by Sean Allen on 3/29/18.
//  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)        
    }
    
    // MARK: Scene Lifecycle
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
