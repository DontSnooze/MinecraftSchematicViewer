//
//  NodeBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation
import SceneKit

struct NodeBlock {
    var name = ""
    var attributes: NodeBlockAttributes
    var paletteId = -1
    
    init(with name: String, attributesString: String, paletteId: Int) {
        self.name = name
        self.paletteId = paletteId
        attributes = NodeBlockAttributes(with: name, attributesString: attributesString)
    }
    
    func scnNode() -> SCNNode? {
        var block: SCNNode?
        
        switch attributes.blockType {
        case .block:
            block = SCNNode.blockFromName(blockName: name)
        case .button:
            block = SCNNode.buttonBlockFromName(blockName: name, attributes: attributes)
        case .chain:
            block = SCNNode.chainBlockFromName(blockName: name)
        case .chest:
            block = SCNNode.chestBlockFromName(blockName: name, attributes: attributes)
        case .comparator:
            block = SCNNode.comparatorNodeFromName(blockName: name, attributes: attributes)
        case .door:
            block = SCNNode.doorNodeFromName(blockName: name, attributes: attributes)
        case .fence:
            block = SCNNode.fenceBlockFromName(blockName: name, directions: attributes.directions)
        case .fenceGate:
            block = SCNNode.fenceGateNodeFromName(blockName: name, attributes: attributes)
        case .glassPane:
            block = SCNNode.glassPaneBlockFromName(blockName: name, directions: attributes.directions)
        case .grassBlock:
            block = SCNNode.grassBlock()
        case .hopper:
            let isFacingDown = attributes.facing == .down
            block = SCNNode.hopperBlockFromName(blockName: name, isFacingDown: isFacingDown)
        case .lantern:
            block = SCNNode.lanternBlockFromName(blockName: name, isHanging: attributes.isHanging)
        case .lever:
            block = SCNNode.leverNodeFromName(blockName: name)
        case .rail:
            block = SCNNode.railBlockFromName(blockName: name, isPowered: attributes.isPowered, shape: attributes.shape)
        case .redstone:
            block = SCNNode.redstoneDustDotNodeFromName(blockName: name, attributes: attributes)
        case .repeater:
            block = SCNNode.repeaterNodeFromName(blockName: name, attributes: attributes)
        case .sign:
            block = SCNNode.signBlockFromName(blockName: name)
        case .slab:
            block = SCNNode.slabBlockFromName(blockName: name)
        case .stairs:
            block = SCNNode.stairsBlockFromName(blockName: name, halfType: attributes.halfType)
        case .wallSign:
            block = SCNNode.signBlockFromName(blockName: name, isWallSign: true)
        case .water:
            block = SCNNode.waterBlock()
        case .wood:
            block = SCNNode.woodBlockFromName(blockName: name)
        }
        
        if let block = block {
            applyAttributes(to: block)
        }
        
        return block
    }
    
    func applyAttributes(to block: SCNNode) {
        switch attributes.blockType {
        case .block:
            applyDirectionAttribute(to: block)
        case .hopper:
            applyDirectionAttribute(to: block)
        case .lantern:
            applyLanternAttributes(to: block, isHanging: attributes.isHanging)
        case .lever:
            applyLeverAttributes(to: block)
        case .rail:
            applyRailAttributes(to: block)
        case .slab:
            applySlabAttributes(to: block)
        case .stairs:
            applyStairsAttributes(to: block)
        case .wallSign:
            applyDirectionAttribute(to: block)
        default:
            break
        }
        
        if attributes.axis != .none {
            applyAxisAttribute(to: block)
        }
    }
    
    func applyDirectionAttribute(to block: SCNNode) {
        switch attributes.facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            guard attributes.blockType != .hopper else {
                break
            }
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
    
    func applyAxisAttribute(to block: SCNNode) {
        switch attributes.axis {
        case .x:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: 0, y: 0, z: radial, duration: 0))
        case .y:
            // default
            break
        case .z:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .none:
            break
        }
    }
}
