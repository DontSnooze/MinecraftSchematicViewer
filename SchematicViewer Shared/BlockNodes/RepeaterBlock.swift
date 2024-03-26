//
//  RepeaterBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class RepeaterBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/repeater.scn") else {
            print("repeater scene is nil")
            return
        }
        
        let blockNodeName = attributes.isPowered ? "repeater_node_on" : "repeater_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("repeater node is nil")
            return
        }
        
        node = blockNode.flattenedClone()
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
}
