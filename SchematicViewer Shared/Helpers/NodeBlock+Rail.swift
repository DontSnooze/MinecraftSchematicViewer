//
//  NodeBlock+Rail.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension NodeBlock {
    func applyRailAttributes(to block: SCNNode) {
        switch attributes.shape {
        case .north_east:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .north_west:
            let radial = CGFloat(GLKMathDegreesToRadians(180))
            block.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .south_east:
            // default
            break
        case .south_west:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            block.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .east_west:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .north_south:
            // default
            break
        default:
            break
        }
    }
}
