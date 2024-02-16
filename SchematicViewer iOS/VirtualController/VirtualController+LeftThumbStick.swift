//
//  VirtualController+LeftThumbStick.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController

extension VirtualController {
    func setupLeftThumbstick(gamepad: GCExtendedGamepad) {
        let thumbstick = gamepad.leftThumbstick
        
        thumbstick.valueChangedHandler = { [unowned self] _, xValue, yValue in
            // code to handle move around
            if xValue > 0.5 {
                // pressing right
                delegate?.horizontalMovementStopped()
                delegate?.leftThumbstickMovedRight()
                
            } else if xValue < -0.5 {
                // pressing left
                delegate?.horizontalMovementStopped()
                delegate?.leftThumbstickMovedLeft()
            } else {
                // center
                if xValue == 0,
                   yValue == 0 {
                    delegate?.horizontalMovementStopped()
                }
            }
            
            if yValue > 0.5 {
                // pressing up
                delegate?.forwardMovementStopped()
                delegate?.leftThumbstickMovedUp()
                
            } else if yValue < -0.5 {
                // pressing down
                delegate?.forwardMovementStopped()
                delegate?.leftThumbstickMovedDown()
            } else {
                // center
                if xValue == 0,
                   yValue == 0 {
                    delegate?.forwardMovementStopped()
                }
            }
        }
    }
}
