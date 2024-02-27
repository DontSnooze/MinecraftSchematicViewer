//
//  NodeBlock+Lantern.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension NodeBlock {
    func applyLanternAttributes(to block: SCNNode, isHanging: Bool = false) {
        if isHanging {
            block.runAction(SCNAction.moveBy(x: 0, y: 0.325, z: 0, duration: 0))
        } else {
            block.runAction(SCNAction.moveBy(x: 0, y: -0.375, z: 0, duration: 0))
        }
    }
}
