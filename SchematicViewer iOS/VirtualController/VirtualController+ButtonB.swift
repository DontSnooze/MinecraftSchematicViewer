//
//  VirtualController+ButtonB.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import GameController

extension VirtualController {
    func setupButtonB(gamepad: GCExtendedGamepad) {
        let buttonB = gamepad.buttonB
        
        buttonB.valueChangedHandler = {(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void in
            // button B clicked            
            if value == 0 {
                // releasing B
                self.delegate?.verticalMovementStopped()
                self.delegate?.buttonBReleased()
                
            } else {
                // holding B
                self.delegate?.verticalMovementStopped()
                self.delegate?.buttonBPressed()
            }
        }
    }
}
