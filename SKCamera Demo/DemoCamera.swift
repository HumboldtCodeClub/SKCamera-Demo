//
//  DemoCamera.swift
//  SKCamera Demo
//
//  Created by Sean Allen on 3/30/18.
//  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import SpriteKit

class DemoCamera: SKCameraNode {
    
    // MARK: Properties
    
    let friction: CGFloat = 0.93
    let attractiveForce: CGFloat = 0.01
    var velocity: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    var attraction: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    override init() {
        super.init()
    }
    
    // MARK: Update Functions
}

