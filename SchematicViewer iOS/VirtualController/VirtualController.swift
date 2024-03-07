//
//  VirtualJoystick.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController
import SceneKit

class VirtualController {
    static let movementSpeedMultiplier: Float = 4
    static let verticalMovementSpeedMultiplier: Float = 0.1
    static let lookAroundSpeedMultiplier: Float = 20
    
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
    }
    
    @objc
    func handleControllerDidConnect(_ notification: Notification) {
        guard let gameController = notification.object as? GCController else {
            print("gameController is nil")
            return
        }
        
        _ = "MFi Controller: \(String(describing: gameController.vendorName)) is connected"
//        print(status)
    }
    
    @objc
    func handleControllerDidDisconnect(_ notification: Notification) {
        if #available(iOS 15.0, *) {
            if GCController.controllers().isEmpty {
                virtualController?.connect()
            }
        }
    }
}
