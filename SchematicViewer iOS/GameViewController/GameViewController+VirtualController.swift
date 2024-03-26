//
//  GameViewController+VirtualControllerDelegate.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import Foundation
import SceneKit

extension GameViewController: GameSceneControllerDelegate {
    func frameWillRender() {
        updateMovementPosition()
        updateLookAraoundPosition()
        handleAbutton()
        handleBbutton()
    }
    
    func updateMovementPosition() {
        let controllerX = virtualController.virtualController?.controller?.extendedGamepad?.leftThumbstick.xAxis.value ?? 0
        let controllerY = virtualController.virtualController?.controller?.extendedGamepad?.leftThumbstick.yAxis.value ?? 0
        let playerNode = gameSceneController.playerNode
        let multiplier: Float = VirtualController.movementSpeedMultiplier
        let y = playerNode.position.y
        
        if controllerX > 0 {
            playerNode.simdPosition += playerNode.simdWorldRight * controllerX / multiplier
            playerNode.position.y = y
        }
        
        if controllerX < 0 {
            playerNode.simdPosition += playerNode.simdWorldRight * controllerX / multiplier
            playerNode.position.y = y
        }
        
        if controllerY > 0 {
            playerNode.simdPosition += playerNode.simdWorldFront * controllerY / multiplier
            playerNode.position.y = y
        }
        
        if controllerY < 0 {
            playerNode.simdPosition += playerNode.simdWorldFront * controllerY / multiplier
            playerNode.position.y = y
        }
    }
    
    func updateLookAraoundPosition() {
        let controllerX = virtualController.virtualController?.controller?.extendedGamepad?.rightThumbstick.xAxis.value ?? 0
        let controllerY = virtualController.virtualController?.controller?.extendedGamepad?.rightThumbstick.yAxis.value ?? 0
        let playerNode = gameSceneController.playerNode
        let multiplier = VirtualController.lookAroundSpeedMultiplier
        
        if controllerX > 0 {
            playerNode.runAction(
                SCNAction.rotateBy(
                    x: 0.0,
                    y: CGFloat(-controllerX / multiplier),
                    z: 0.0,
                    duration: 0.1
                )
            )
        }
        
        if controllerX < 0 {
            playerNode.runAction(
                SCNAction.rotateBy(
                    x: 0.0,
                    y: CGFloat(-controllerX / multiplier),
                    z: 0.0,
                    duration: 0.1
                )
            )
        }
        
        if controllerY > 0 {
            playerNode.runAction(
                SCNAction.rotateBy(
                    x: CGFloat(controllerY / multiplier),
                    y: 0.0,
                    z: 0.0,
                    duration: 0.1
                )
            )
        }
        
        if controllerY < 0 {
            playerNode.runAction(
                SCNAction.rotateBy(
                    x: CGFloat(controllerY / multiplier),
                    y: 0.0,
                    z: 0.0,
                    duration: 0.1
                )
            )
        }
    }
    
    func handleAbutton() {
        guard virtualController.virtualController?.controller?.extendedGamepad?.buttonA.isPressed != false else {
            return
        }
        
        let playerNode = gameSceneController.playerNode
        playerNode.position.y -= VirtualController.verticalMovementSpeedMultiplier
    }
    
    func handleBbutton() {
        guard virtualController.virtualController?.controller?.extendedGamepad?.buttonB.isPressed != false else {
            return
        }
        
        let playerNode = gameSceneController.playerNode
        playerNode.position.y += VirtualController.verticalMovementSpeedMultiplier
    }
    
    func resetPosition() {
        let playerNode = gameSceneController.playerNode
        playerNode.position = SCNVector3(x: 0, y: 1, z: 3)
        playerNode.eulerAngles = SCNVector3Make(0, 0, 0)
    }
}
