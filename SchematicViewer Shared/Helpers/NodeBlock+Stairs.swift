//
//  NodeBlock+Stairs.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import Foundation
import SceneKit

extension NodeBlock {
    func applyStairsAttributes(to block: SCNNode) {        
        switch halfType {
        case .top:
            let radial = GLKMathDegreesToRadians(180)
            block.runAction(SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(radial), duration: 0))
        default:
            break
        }
        
        switch facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let degrees: Float = halfType == .bottom ? -90 : 90
            let radial = GLKMathDegreesToRadians(degrees)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let degrees: Float = halfType == .bottom ? 90 : -90
            let radial = GLKMathDegreesToRadians(degrees)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
}
