# SKCamera Demo 

In the process of developing a board game that needed a top down camera with pan and zoom abilities we quickly realized it would be easier to develop tweak and test without all the game logic and other junk needed for a full game.

This demo application was created for the purpose of doing the main camera development and configuration in a clean environment and then drop it into our games and apply final configuration tweaks.

## Requirements

* Simultaneous Pan and Zoom
* Smooth transitions after user interaction ends
* Pan and zoom range limits with soft edges

### Simultaneous Pan and Zoom

The camera must allow the user to pan and zoom at the same time with a single touch interaction. Pan and zoom have been implemented with a UIPanGestureRecognizer and a UIPinchGestureRecognizer. Simultaneous gestures are implemented through the UIGestureRecognizerDelegate.

### Smooth Transitions

We wanted the camera to perform like a real world object. So a flick would send it sliding even after the touch ends and you can catch it by touching the screen again.  Imagine flicking a playing card around on a card table.  

Rather than add a full physics body we subclassed the SKCameraNode and added velocity and friction attributes.  Our gesture recognizers set the velocity of the camera and its position is updated based on that velocity.  By multiplying velocity by friction we end up with a camera that will slow to a stop after user interaction ends rather than halt abruptly.

By setting the velocity to zero in the touchesBegan() method we are able to give the effect of pinning the camera under your finger if it was moving prior to the touch.

Another important revelation that this project exposed was that panning and zooming effects seem to diminish as the camera zooms out.  Really the rate at which the camera is moving doesn't change, but our perspective changes, so it seems slower at larger zoom scales.  By multiplying the velocity by the scale we are able to give the impression of consistent swipe and zoom rates at all scales.

### Pan and zoom range limits with soft edges
We found it simple to set minimum and maximum ranges where the camera would be confined, but found it distastful to have an abrupt hault to the camera's motion at these boundries.

Our solution was to create a soft edge effect where the camera could travel past its boundries and would softly rebound back to the exceded limit.  We added a attraction property, similar to velocity, that is updated when the camera leaves its bounds and pulls the camera back within its designated ranges.



## Implementation

1. Add DemoCamera subclass of SKCameraNode to your project
    * Add DemoCamera.swift to your project or create a similar subclass.  
2. GameScene.swift  
Configure your camera in the init function of your scene.
    * Configure the camera attributes.
    * Set the scene's camera to the demo camera instance
    * Add the camera node as a child of the scene (so HUD can be displayed)
    * Call the camera's update function from the scene's update function
3. GameViewController.swift  
Use gesture recognizers and touches to update the camera's velocity based on user touch input.
    * Create a UIPanGestureRecognizer and selector function.  Update the camera's x and y velocities based on the gesture recognizer velocity.
    * Create a UIPinchGestureRecognizer and selector function.  Update the camera's z velocity based on the gesture recognizer velocity.
    * Implement the touchesBegan function and call the camera's stop function to give the effect of catching a moving camera under your finger.

## Dependencies

* Swift 4
* Xcode


