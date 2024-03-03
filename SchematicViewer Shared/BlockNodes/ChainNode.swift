//
//  ChainNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func chainBlockFromName(blockName: String, isHanging: Bool = false) -> SCNNode {
        
        let block = SCNNode.chainBlockNode()
        
        block.name = blockName
        
        return block
    }
    
    private static func chainBlockNode() -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/chain.scn") else {
            fatalError("chain scene is nil")
        }
        
        let blockNodeName = "chain"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("chain node is nil")
        }
        
        return blockNode
    }
}
