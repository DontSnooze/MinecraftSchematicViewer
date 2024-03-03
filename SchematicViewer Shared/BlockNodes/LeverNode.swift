//
//  LeverNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func leverNodeFromName(blockName: String) -> SCNNode {
        
        let block = SCNNode.leverNode()
        
        block.name = blockName
        
        return block
    }
    
    private static func leverNode() -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/lever.scn") else {
            fatalError("lever scene is nil")
        }
        
        let blockNodeName = "lever_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("lever node is nil")
        }
        
        return blockNode
    }
}
