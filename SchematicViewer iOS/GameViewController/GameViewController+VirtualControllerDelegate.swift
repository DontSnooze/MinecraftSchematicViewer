//
//  GameViewController+VirtualControllerDelegate.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import SceneKit

extension GameViewController: VirtualControllerDelegate {
    func leftThumbstickMovedUp() {
        gameSceneController.playerNode.simdPosition += gameSceneController.playerNode.simdWorldFront * Float(virtualController.movementSpeed)
        leftThumbstickVerticalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.gameSceneController.playerNode.simdPosition += self.gameSceneController.playerNode.simdWorldFront * Float(self.virtualController.movementSpeed)
        })
    }
    
    func leftThumbstickMovedDown() {
        gameSceneController.playerNode.simdPosition += gameSceneController.playerNode.simdWorldFront * Float(-virtualController.movementSpeed)
        leftThumbstickVerticalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.gameSceneController.playerNode.simdPosition += self.gameSceneController.playerNode.simdWorldFront * Float(-self.virtualController.movementSpeed)
        })
    }
    
    func leftThumbstickMovedLeft() {
        gameSceneController.playerNode.simdPosition += gameSceneController.playerNode.simdWorldRight * Float(-virtualController.movementSpeed)
        leftThumbstickHorizontalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.gameSceneController.playerNode.simdPosition += self.gameSceneController.playerNode.simdWorldRight * Float(-self.virtualController.movementSpeed)
        })
    }
    
    func leftThumbstickMovedRight() {
        gameSceneController.playerNode.simdPosition += gameSceneController.playerNode.simdWorldRight * Float(virtualController.movementSpeed)
        leftThumbstickHorizontalTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.gameSceneController.playerNode.simdPosition += self.gameSceneController.playerNode.simdWorldRight * Float(self.virtualController.movementSpeed)
        })
    }
    
    func leftThumbstickCenter() {
        //
    }
    
    func rightThumbstickMovedUp() {
        let action = SCNAction.repeatForever(
            SCNAction.rotateBy(
                x: virtualController.lookAroundSpeed,
                y: 0.0,
                z: 0.0,
                duration: 0.1
            )
        )
        
        gameSceneController.playerNode.runAction(action, forKey: "forward_rotations")
    }
    
    func rightThumbstickMovedDown() {
        let action = SCNAction.repeatForever(
            SCNAction.rotateBy(
                x: -virtualController.lookAroundSpeed,
                y: 0.0,
                z: 0.0,
                duration: 0.1
            )
        )
        
        gameSceneController.playerNode.runAction(action, forKey: "backward_rotations")
    }
    
    func rightThumbstickMovedLeft() {
        let action = SCNAction.repeatForever(
            SCNAction.rotateBy(
                x: 0.0,
                y: virtualController.lookAroundSpeed,
                z: 0.0,
                duration: 0.1
            )
        )
        gameSceneController.playerNode.runAction(action, forKey: "left_rotations")
    }
    
    func rightThumbstickMovedRight() {
        let action = SCNAction.repeatForever(
            SCNAction.rotateBy(
                x: 0.0,
                y: -virtualController.lookAroundSpeed,
                z: 0.0,
                duration: 0.1
            )
        )
        gameSceneController.playerNode.runAction(action, forKey: "right_rotations")
    }
    
    func rightThumbstickCenter() {
        //
    }
    
    func horizontalMovementStopped() {
        stopHorizontalMovement()
    }
    
    func forwardMovementStopped() {
        stopForwardMovement()
    }
    
    func verticalRotationStopped() {
        stopVerticalRotations()
    }
    
    func horizontalRotationStopped() {
        stopHorizontalRotations()
    }
    
    func verticalMovementStopped() {
        stopVerticalMovement()
    }
    
    func buttonAPressed() {
        let action = SCNAction.repeatForever(
            SCNAction.moveBy(
                x: 0.0,
                y: -virtualController.verticalMovementSpeed,
                z: 0.0,
                duration: 0.1
            )
        )
        
        gameSceneController.playerNode.runAction(action, forKey: "down_movement")
    }
    
    func buttonAReleased() {
        stopVerticalMovement()
    }
    
    func buttonBPressed() {
        let action = SCNAction.repeatForever(
            SCNAction.moveBy(
                x: 0.0,
                y: virtualController.verticalMovementSpeed,
                z: 0.0,
                duration: 0.1
            )
        )
        
        self.gameSceneController.playerNode.runAction(action, forKey: "up_movement")
    }
    
    func buttonBReleased() {
        stopVerticalMovement()
    }
    
    func stopVerticalRotations() {
        let keys = [
            "left_rotations",
            "right_rotations"
        ]
        
        for key in keys {
            gameSceneController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopHorizontalRotations() {
        let keys = [
            "forward_rotations",
            "backward_rotations"
        ]
        
        for key in keys {
            gameSceneController.playerNode.removeAction(forKey: key)
        }
    }
    
    func stopForwardMovement() {
        leftThumbstickVerticalTimer?.invalidate()
    }
    
    func stopHorizontalMovement() {
        leftThumbstickHorizontalTimer?.invalidate()
    }
    
    func stopVerticalMovement() {
        let keys = [
            "up_movement",
            "down_movement"
        ]
        
        for key in keys {
            gameSceneController.playerNode.removeAction(forKey: key)
        }
    }
}
