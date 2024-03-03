//
//  RedstoneDustDot.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func redstoneDustDotNodeFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        
        let block = redstoneDustDotNode(isPowered: attributes.isPowered)
        
        block.name = blockName
        
        return block
    }
    
    private static func redstoneDustDotNode(isPowered: Bool = false) -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/redstone_dust_dot.scn") else {
            fatalError("redstone scene is nil")
        }
        
        let blockNodeName = isPowered ? "redstone_dust_dot_node_active" : "redstone_dust_dot_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("redstone node is nil")
        }
        
        return blockNode
    }
}
