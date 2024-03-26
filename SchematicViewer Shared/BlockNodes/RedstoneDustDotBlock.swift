//
//  RedstoneDustDotBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class RedstoneDustDotBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/redstone_dust_dot.scn") else {
            print("redstone scene is nil")
            return
        }
        
        let blockNodeName = attributes.isPowered ? "redstone_dust_dot_node_active" : "redstone_dust_dot_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("redstone node is nil")
            return
        }
        
        node = blockNode.flattenedClone()
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
