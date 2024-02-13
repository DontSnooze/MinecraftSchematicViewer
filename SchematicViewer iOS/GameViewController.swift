//
//  GameViewController.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/8/24.
//

import UIKit
import SceneKit
import GameController

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
        self.gameView.allowsCameraControl = true
        
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
    
    func registerGameController(_ gameController: GCController) {
        print("registerGameController start")
        var leftThumbstick: GCControllerDirectionPad?
        var buttonA: GCControllerButtonInput?
        var buttonB: GCControllerButtonInput?
        
        if let gamepad = gameController.extendedGamepad {
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
            } else if xValue < -0.5 {
                // pressing left
                print("Left Pressed")
            } else {
                // center
                print("Center Pressed")
            }
            
            if yValue > 0.5 {
                // pressing up
                print("Up Pressed")
                
            } else if yValue < -0.5 {
                // pressing down
                print("Down Pressed")
                
            } else {
                // center
                print("Center Pressed")
            }
        }
        
        buttonA?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // Put here the codes to run when button A clicked
            print("Button A Pressed")
            
            if value == 0 {
                // releasing A
                print("releasing A")
            } else {
                // holding A
                print("holding A")
            }
        }
        
        buttonB?.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // Put here the codes to run when button B clicked
            print("Button B Pressed")
            
            if value == 0 {
                // releasing B
                print("releasing B")
                
            } else {
                // holding B
                print("holding B")
                
            }
        }
    }
    
    func unregisterGameController() {
        print("unregisterGameController start")
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
