# SKCamera Demo 

## Dependencies
* Swift 4
* Xcode

## Implementation

* Subclass SKCameraNode  
    1. Add DemoCamera.swift to your project of create a similar subclass.   
* Add an instance of DemoCamera to a scene
    1. Configure the camera
    2. Set the scene's camera to the demo camera instance
    3. Add the camera node as a child of the scene (so HUD can be displayed)
    4. Call the camera's update function from the scene's update function
* Use gesture recognizers to update the camera's velocity based on user touch input

## Contributing to the project

Please check the [CONTRIBUTING.md](CONTRIBUTING.md) doc for contribution guidelines.

## Getting Help

Please, do not open issues for the general support questions as we want to keep GitHub issues for bug reports and feature requests. You've got much better chances of getting your question answered on [StackOverflow](http://stackoverflow.com/questions/tagged/SKCameraNode) where maintainers are looking at questions tagged with `SKCameraNode`.

StackOverflow is a much better place to ask questions since:
* there are hundreds of people willing to help on StackOverflow
* questions and answers stay available for public viewing so your question / answer might help someone else
* SO voting system assures that the best answers are prominently visible.

To save your and our time we will be systematically closing all the issues that are requests for general support and redirecting people to StackOverflow.

## Code of Conduct

Please take a moment and read our [Code of Conduct](CODE_OF_CONDUCT.md)