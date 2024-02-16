//
//  VirtualJoystick.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController
import SceneKit

protocol VirtualControllerDelegate: AnyObject {
    func leftThumbstickMovedUp()
    func leftThumbstickMovedDown()
    func leftThumbstickMovedLeft()
    func leftThumbstickMovedRight()
    func leftThumbstickCenter()
    
    func rightThumbstickMovedUp()
    func rightThumbstickMovedDown()
    func rightThumbstickMovedLeft()
    func rightThumbstickMovedRight()
    func rightThumbstickCenter()
    
    func horizontalMovementStopped()
    func forwardMovementStopped()
    
    func verticalRotationStopped()
    func horizontalRotationStopped()
    
    func verticalMovementStopped()
    
    func buttonAPressed()
    func buttonAReleased()
    
    func buttonBPressed()
    func buttonBReleased()
}

class VirtualController {
    
    var delegate: VirtualControllerDelegate?
    let movementSpeed = 0.5
    let verticalMovementSpeed = 0.25
    let lookAroundSpeed = 0.1
    
    // Virtual Onscreen Controller
    private var _virtualController: Any?
    @available(iOS 15.0, *)
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController }
        set { self._virtualController = newValue }
    }
    
    func setup() {
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
        guard let gameController = notification.object as? GCController else {
//            print("gameController is nil")
            return
        }
        
//        let status = "MFi Controller: \(String(describing: gameController.vendorName)) is connected"
//        print(status)
        
        unregisterGameController()
        
        //
        // This breaks it and causes the controller not to appear
        // (Guessing our controller gets disconnected)
        //
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
        unregisterGameController()
        
        if #available(iOS 15.0, *) {
            if GCController.controllers().isEmpty {
                virtualController?.connect()
            }
        }
    }
    
    func registerGameController(_ controller: GCController) {
        if let gamepad = controller.extendedGamepad {
            setupLeftThumbstick(gamepad: gamepad)
            setupRightThumbstick(gamepad: gamepad)
            setupButtonA(gamepad: gamepad)
            setupButtonB(gamepad: gamepad)
        }
    }
    
    func unregisterGameController() {
//        print("unregisterGameController start")
    }
}
