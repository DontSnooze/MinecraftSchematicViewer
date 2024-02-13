//
//  GameViewController.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/8/24.
//

import UIKit
import SceneKit
import GameController
import SpriteKit

class GameViewController: UIViewController {

    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    // Virtual Onscreen Controller
    private var _virtualController: Any?
    @available(iOS 15.0, *)
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController }
        set { self._virtualController = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameController = GameController(sceneRenderer: gameView)
        // Allow the user to manipulate the camera
//        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = UIColor.black
        
        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        var gestureRecognizers = gameView.gestureRecognizers ?? []
        gestureRecognizers.insert(tapGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
        setupGameController()
    }
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // Highlight the tapped nodes
        let p = gestureRecognizer.location(in: gameView)
        gameController.highlightNodes(atPoint: p)
    }
    
    func setupGameController() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidConnect),
            name: NSNotification.Name.GCControllerDidBecomeCurrent, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidDisconnect),
            name: NSNotification.Name.GCControllerDidStopBeingCurrent, object: nil)
        
        if #available(iOS 15.0, *) {
            let virtualConfiguration = GCVirtualController.Configuration()
            virtualConfiguration.elements = [GCInputLeftThumbstick,
                                             GCInputRightThumbstick,
                                             GCInputButtonA,
                                             GCInputButtonB]
            virtualController = GCVirtualController(configuration: virtualConfiguration)
            
            // Connect to the virtual controller if no physical controllers are available.
            if GCController.controllers().isEmpty {
                print("virtualController?.connect()")
                virtualController?.connect()
            }
        }
        
        guard let controller = GCController.controllers().first else {
            return
        }
        registerGameController(controller)
    }
    
    @objc 
    func handleControllerDidConnect(_ notification: Notification) {
        print("handleControllerDidConnect start")
        guard let gameController = notification.object as? GCController else {
            print("gameController is nil")
            return
        }
        
        let status = "MFi Controller: \(String(describing: gameController.vendorName)) is connected"
        
        print(status)
        
        unregisterGameController()
        
//        if #available(iOS 15.0, *) {
//            if gameController != virtualController?.controller {
//                print("gameController != virtualController?.controller")
//                virtualController?.disconnect()
//            }
//        }
        
        registerGameController(gameController)
    }
    
    @objc 
    func handleControllerDidDisconnect(_ notification: Notification) {
        print("handleControllerDidDisconnect start")
        unregisterGameController()
        
        if #available(iOS 15.0, *) {
            if GCController.controllers().isEmpty {
                virtualController?.connect()
            }
        }
    }
    
    func registerGameController(_ controller: GCController) {
        print("registerGameController start")
        var leftThumbstick: GCControllerDirectionPad?
        var rightThumbstick: GCControllerDirectionPad?
        var buttonA: GCControllerButtonInput?
        var buttonB: GCControllerButtonInput?
        var rotationSpeed = 0.25
        
        if let gamepad = controller.extendedGamepad {
            rightThumbstick = gamepad.rightThumbstick
            leftThumbstick = gamepad.leftThumbstick
            buttonA = gamepad.buttonA
            buttonB = gamepad.buttonB
        }
        
        leftThumbstick?.valueChangedHandler = { [unowned self] _, xValue, yValue in
            
            // Code to handle movement here ...
            
            print("xValue: \(xValue)")
            print("yValue: \(yValue)")
            
            if xValue > 0.5 {
                // pressing right
                print("Right Pressed")
                let action = SCNAction.repeatForever(
                    SCNAction.moveBy(
                        x: rotationSpeed,
                        y: 0.0,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                stopHorizontalMovement()
                gameController.playerNode.runAction(action, forKey: "right_movement")
            } else if xValue < -0.5 {
                // pressing left
                print("Left Pressed")
                let action = SCNAction.repeatForever(
                    SCNAction.moveBy(
                        x: -rotationSpeed,
                        y: 0.0,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                stopHorizontalMovement()
                gameController.playerNode.runAction(action, forKey: "left_movement")
            } else {
                // center
                print("Center Pressed")
                if xValue == 0,
                   yValue == 0 {
                    stopHorizontalMovement()
                }
            }
            
            if yValue > 0.5 {
                // pressing up
                print("forward Pressed")
                
                gameController.playerNode.position += getZForward(node: gameController.playerNode) * SCNVector3.VecFloat(-rotationSpeed)
                
            } else if yValue < -0.5 {
                // pressing down
                print("Backwards Pressed")
                
                gameController.playerNode.position += getZForward(node: gameController.playerNode) * SCNVector3.VecFloat(rotationSpeed)
            } else {
                // center
                print("Center Pressed")
                if xValue == 0,
                   yValue == 0 {
                    stopForwardMovement()
                }
            }
        }
        
        rightThumbstick?.valueChangedHandler = { [unowned self] _, xValue, yValue in
            
            // Code to handle look around here ...
            let currentRotation = gameController.playerNode.rotation.y
            print("xValue: \(xValue)")
            print("yValue: \(yValue)")
            
            if xValue > 0.5 {
                // pressing right
                print("Right Pressed, rotation: \(currentRotation)")
                
                // action that rotates the node to an angle in radian.
                
                let action = SCNAction.repeatForever(
                    SCNAction.rotateBy(
                        x: 0.0,
                        y: -rotationSpeed,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                stopVerticalRotations()
                gameController.playerNode.runAction(action, forKey: "right_rotations")
                
            } else if xValue < -0.5 {
                // pressing left
                print("Letf Pressed, rotation: \(currentRotation)")
                let action = SCNAction.repeatForever(
                    SCNAction.rotateBy(
                        x: 0.0,
                        y: rotationSpeed,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                stopVerticalRotations()
                gameController.playerNode.runAction(action, forKey: "left_rotations")
            } else {
                // center
                print("Center Pressed")
                if xValue == 0,
                   yValue == 0 {
                    stopVerticalRotations()
                }
            }
            
            if yValue > 0.5 {
                // pressing up
                print("Up Pressed. rotation x: \(gameController.playerNode.rotation.x)")
                let action = SCNAction.repeatForever(
                    SCNAction.rotateBy(
                        x: rotationSpeed,
                        y: 0.0,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                stopHorizontalRotations()
                gameController.playerNode.runAction(action, forKey: "forward_rotations")
                
            } else if yValue < -0.5 {
                // pressing down
                print("Down Pressed. rotation x: \(gameController.playerNode.rotation.x)")
                let action = SCNAction.repeatForever(
                    SCNAction.rotateBy(
                        x: -rotationSpeed,
                        y: 0.0,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                
                stopHorizontalRotations()
                gameController.playerNode.runAction(action, forKey: "backward_rotations")
                
            } else {
                // center
                print("Center Pressed")
                if xValue == 0,
                   yValue == 0 {
                    stopHorizontalRotations()
                }
            }
        }
        
        buttonA?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // Put here the codes to run when button A clicked
            print("Button A Pressed")
            
            if value == 0 {
                // releasing A
                print("releasing A")
                self.stopVerticalMovement()
            } else {
                // holding A
                print("holding A")
                let action = SCNAction.repeatForever(
                    SCNAction.moveBy(
                        x: 0.0,
                        y: -rotationSpeed,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                
                self.stopVerticalMovement()
                self.gameController.playerNode.runAction(action, forKey: "down_movement")
            }
        }
        
        buttonB?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // Put here the codes to run when button B clicked
            print("Button B Pressed")
            
            if value == 0 {
                // releasing B
                print("releasing B")
                
                self.stopVerticalMovement()
                
            } else {
                // holding B
                print("holding B")
                let action = SCNAction.repeatForever(
                    SCNAction.moveBy(
                        x: 0.0,
                        y: rotationSpeed,
                        z: 0.0,
                        duration: 0.1
                    )
                )
                self.stopVerticalMovement()
                self.gameController.playerNode.runAction(action, forKey: "up_movement")
            }
        }
    }
    
    func stopVerticalRotations() {
        let keys = [
            "left_rotations",
            "right_rotations"
        ]
        
        for key in keys {
            gameController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopHorizontalRotations() {
        let keys = [
            "forward_rotations",
            "backward_rotations"
        ]
        
        for key in keys {
            gameController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopForwardMovement() {
        let keys = [
            "forward_movement",
            "backward_movement"
        ]
        
        for key in keys {
            gameController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopHorizontalMovement() {
        let keys = [
            "right_movement",
            "left_movement"
        ]
        
        for key in keys {
            gameController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopVerticalMovement() {
        let keys = [
            "up_movement",
            "down_movement"
        ]
        
        for key in keys {
            gameController.playerNode.removeAction(forKey: key)
        }
    }
    
    func unregisterGameController() {
        print("unregisterGameController start")
    }
    
    func getZForward(node: SCNNode) -> SCNVector3 {
        return SCNVector3(node.worldTransform.m31, node.worldTransform.m32, node.worldTransform.m33)
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

}

extension SCNVector3 {
#if os(iOS)
    typealias VecFloat = Float
#elseif os (OSX)
    typealias VecFloat = CGFloat
#endif
    
    static func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    static func * (lhs: SCNVector3, rhs: VecFloat) -> SCNVector3 {
        return SCNVector3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }
    
    static func += (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs + rhs
    }
}
