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
    
    // velocity is the value that the camera should move each frame in the x, y and z direction.
    // x and y are position values and will adjust the pixel location of the camera in the scene.
    // z is a scale value and will adjust the scale of the camera's viewport.
    var velocity: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    // friction is a used to decrease the velocity of the camera after user interaction has
    // ended to cause the camera to gradually slow to a stop.
    let friction: CGFloat = 0.93
    
    // attraction is a value derived from the distance the camera's position is outside of the
    // camera's range.  It is used along with the attractive force to provide a 'soft' edge to
    // the camera's range, allowing it to cross its min and max slightly and bounce back.
    var attraction: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)
    
    // attractiveForce sets the 'softness' of the edge of the camera's range.
    // A value of 1.0 will be a hard edge where the camera stops at it min and max ranges with no give or bounce.
    // Smaller values will allow the camera to travel farther past its range and bounce back.
    // A value of 0.0 will allow the camera to completely ignore its defined range.
    let attractiveForce: CGFloat = 0.25
    
    // The cameras position and scale range
    var range: (x: (min: CGFloat, max: CGFloat),
                y: (min: CGFloat, max: CGFloat),
                z: (min: CGFloat, max: CGFloat)) = ((-1000, 1000), (-1000, 1000),(1, 4))
    
    // A boolean value that indicates whether the camera displays a position indicator.
    var showsPosition = false
    
    // A boolean value that indicates whether the camera displays a scale indicator.
    var showsScale = false
    
    //
    let positionLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    //
    let scaleLabel = SKLabelNode(fontNamed: "AppleSDGothicNeo-SemiBold")
    
    
    // MARK: Initializers
    
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    //
    override init() {
        super.init()
        setupHUD()
    }
    
    // MARK: Setup Functions
    
    //
    func setupHUD() {
        if (showsPosition) {
            positionLabel.fontSize = 8
            positionLabel.fontColor = .white
            addChild(positionLabel)
        }
        
        if (showsScale) {
            scaleLabel.fontSize = 8
            scaleLabel.fontColor = .white
            scaleLabel.position = CGPoint(x:0.0, y: -15.0)
            addChild(scaleLabel)
        }
    }
    
    // MARK: Public Functions
    
    //
    func stop() {
        velocity = (0.0, 0.0, 0.0)
        attraction = (0.0, 0.0, 0.0)
    }
    
    //
    func update() {
        updatePosition()
        updateScale()
        updateHUD()
    }
    
    //
    func setCameraVelocity(x: CGFloat!, y: CGFloat!, z: CGFloat!) {
        setCameraPositionVelocity(x: x, y: y)
        if (z != nil) {
            setCameraScaleVelocity(z: z)
        }
    }
    
    //
    func setCameraPositionVelocity(x: CGFloat!, y: CGFloat!) {
        if (x != nil) {
            velocity.x = x * xScale
        }
        
        if (y != nil) {
            velocity.y = y * yScale
        }
    }
    
    //
    func setCameraScaleVelocity(z: CGFloat) {
        velocity.z = z * xScale
    }
    
    // MARK: Private Functions
    
    //
    private func updatePosition() {
        
        // Update attraction x
        if (position.x < range.x.min) {
            attraction.x = position.x - range.x.min
            attraction.x *= attractiveForce
        } else if (position.x > range.x.max) {
            // Attraction is a positive number
            attraction.x = position.x - range.x.max
            attraction.x *= attractiveForce
        } else {
            attraction.x = 0.0
        }
        
        // Update attraction y
        if (position.y < range.y.min) {
            attraction.y = position.y - range.y.min
            attraction.y *= attractiveForce
        } else if (position.y > range.y.max) {
            attraction.y = position.y - range.y.max
            attraction.y *= attractiveForce
        } else {
            attraction.y = 0.0
        }

        // Apply friction
        velocity.x *= friction
        velocity.y *= friction
        
        // And finally update the position
        position.x -= velocity.x + attraction.x
        position.y += velocity.y - attraction.y
    }
    
    //
    private func updateScale() {
        
        yScale = xScale
        
        if (xScale < range.z.min) {
            attraction.z = range.z.min - xScale
            attraction.z *= attractiveForce
        } else if (xScale > range.z.max) {
            attraction.z = range.z.max - xScale
            attraction.z *= attractiveForce
        } else {
            attraction.z = 0
        }
        
        // Apply Friction
        velocity.z *= friction
        
        // Update the scale
        setScale(xScale - velocity.z + attraction.z)
    }
    
    /**
     Update the camera's SKLabelNode children.
     
     - Author:
     Sean Allen
     
     - Important:
     This function is called by the update() method.
     
     - Version:
     0.1
     
     The updateHUD() funcition is called by the update() method so that when the scale and position debug labels are enabled they
     will accurately display the current camera orientation.  This HUD serves to provide information about the camera state and
     serves as an example of how to implement a HUD by adding nodes as children of the camera.
     */
    private func updateHUD() {
        if (showsPosition) {
            let x = position.x.rounded(FloatingPointRoundingRule.toNearestOrEven)
            let y = position.y.rounded(FloatingPointRoundingRule.toNearestOrEven)
            positionLabel.text = "position: (\(x), \(y))"
        }
        
        if (showsScale) {
            scaleLabel.text = "Scale: \(xScale)"
        }
    }
}

