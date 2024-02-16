//
//  VirtualController+RightThumbStick.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController
import SceneKit

extension VirtualController {
    func setupRightThumbstick(gamepad: GCExtendedGamepad) {
        let thumbstick = gamepad.rightThumbstick
        
        thumbstick.valueChangedHandler = { [unowned self] _, xValue, yValue in
            // Code to handle look around
            if xValue > 0.5 {
                // pressing right
                delegate?.verticalRotationStopped()
                delegate?.rightThumbstickMovedRight()
                
            } else if xValue < -0.5 {
                // pressing left
                delegate?.verticalRotationStopped()
                delegate?.rightThumbstickMovedLeft()
            } else {
                // center
                if xValue == 0,
                   yValue == 0 {
                    delegate?.verticalRotationStopped()
                }
            }
            
            if yValue > 0.5 {
                // pressing up                
                delegate?.horizontalRotationStopped()
                delegate?.rightThumbstickMovedUp()
                
            } else if yValue < -0.5 {
                // pressing down
                delegate?.horizontalRotationStopped()
                delegate?.rightThumbstickMovedDown()
                
            } else {
                // center
                if xValue == 0,
                   yValue == 0 {
                    delegate?.horizontalRotationStopped()
                }
            }
        }
    }
}
