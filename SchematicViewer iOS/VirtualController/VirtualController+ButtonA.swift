//
//  VirtualController+ButtonA.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController

extension VirtualController {
    func setupButtonA(gamepad: GCExtendedGamepad) {
        let buttonA = gamepad.buttonA
        
        buttonA.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // button A clicked
            
            if value == 0 {
                // releasing A
                self.delegate?.verticalMovementStopped()
                self.delegate?.buttonAReleased()
            } else {
                // holding A
                self.delegate?.verticalMovementStopped()
                self.delegate?.buttonAPressed()
            }
        }
    }
}
