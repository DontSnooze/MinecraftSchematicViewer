//
//  RepeaterNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func repeaterNodeFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        
        let block = repeaterNodeFrom(isPowered: attributes.isPowered)
        
        block.name = blockName
        
        return block
    }
    
    private static func repeaterNodeFrom(isPowered: Bool = false) -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/repeater.scn") else {
            fatalError("repeater scene is nil")
        }
        
        let blockNodeName = isPowered ? "repeater_node_on" : "repeater_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("redstone node is nil")
        }
        
        return blockNode
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
    }
}
