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

* Subclass SKCameraNode  
    1. Add DemoCamera.swift to your project of create a similar subclass.   
* Add an instance of DemoCamera to a scene
    1. Configure the camera
    2. Set the scene's camera to the demo camera instance
    3. Add the camera node as a child of the scene (so HUD can be displayed)
    4. Call the camera's update function from the scene's update function
* Use gesture recognizers to update the camera's velocity based on user touch input

## Dependencies

* Swift 4
* Xcode


