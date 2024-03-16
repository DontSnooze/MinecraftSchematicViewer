//
//  ComparatorBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class ComparatorBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/comparator.scn") else {
            print("comparator scene is nil")
            return
        }
        
        let blockNodeName = attributes.isPowered ? "comparator_node_on" : "comparator_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("comparator node is nil")
            return
        }
        
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
}
