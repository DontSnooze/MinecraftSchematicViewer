//
//  ComparatorNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func comparatorNodeFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        
        let block = comparatorNode(isPowered: attributes.isPowered)
        
        block.name = blockName
        
        return block
    }
    
    private static func comparatorNode(isPowered: Bool = false) -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/comparator.scn") else {
            fatalError("comparator scene is nil")
        }
        
        let blockNodeName = isPowered ? "comparator_node_on" : "comparator_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("comparator node is nil")
        }
        
        return blockNode
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
    }
}
