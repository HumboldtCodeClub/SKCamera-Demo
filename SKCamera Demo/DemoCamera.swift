//
//  DemoCamera.swift
//  SKCamera Demo
//
//  Created by Sean Allen on 3/30/18.
//  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import SpriteKit

struct Velocity {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
}

class DemoCamera: SKCameraNode {
    
    // MARK: Properties
    
    var friction: CGFloat = 0.93
    var velocity = Velocity()
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    override init() {
        super.init()
    }
}

