//
//  NodeBlock+Lever.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension NodeBlock {
    func applyLeverAttributes(to block: SCNNode) {
        applyDirectionAttribute(to: block)
        
        switch attributes.face {
        case .ceiling:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .floor:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            block.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        default:
            break
        }
    }
}
