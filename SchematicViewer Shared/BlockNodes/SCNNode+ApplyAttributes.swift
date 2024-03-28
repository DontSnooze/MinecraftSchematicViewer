//
//  SCNNode+ApplyAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    func applyDirectionAttribute(attributes: NodeBlockAttributes) {
        guard !attributes.isSprite else {
            applySpriteDirectionAttributes(attributes: attributes)
            return
        }
        
        switch attributes.facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            guard attributes.blockType != .hopper else {
                break
            }
            let radial = GLKMathDegreesToRadians(-90)
            runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let radial = GLKMathDegreesToRadians(-90)
            runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let radial = GLKMathDegreesToRadians(90)
            runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
    
    func applySpriteDirectionAttributes(attributes: NodeBlockAttributes) {
        let blocksToIgnore = ["bell"]
        guard
            !blocksToIgnore.contains(attributes.name),
            !attributes.name.hasSuffix("campfire")
        else {
            return
        }
        
        switch attributes.facing {
        case .up:
            // already facing up
            break
        case .down:
            let radial = GLKMathDegreesToRadians(180)
            runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            let radial = GLKMathDegreesToRadians(90)
            runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .south:
            let radial = GLKMathDegreesToRadians(-90)
            runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .east:
            let radial = GLKMathDegreesToRadians(-90)
            runAction(SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(radial), duration: 0))
        case .west:
            let radial = GLKMathDegreesToRadians(90)
            runAction(SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(radial), duration: 0))
        case .none:
            break
        }
    }
    
    func applyAxisAttribute(attributes: NodeBlockAttributes) {
        switch attributes.axis {
        case .x:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            runAction(SCNAction.rotateBy(x: 0, y: 0, z: radial, duration: 0))
        case .y:
            // default
            break
        case .z:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .none:
            break
        }
    }
}
