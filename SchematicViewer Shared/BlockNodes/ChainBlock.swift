//
//  ChainBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class ChainBlock: SVNode {
    var attributes: NodeBlockAttributes
    
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/chain.scn") else {
            print("chain scene is nil")
            return
        }
        
        guard let blockNode = scene.rootNode.childNode(withName: "chain", recursively: true) else {
            print("chain node is nil")
            return
        }
        
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyAxisAttribute(attributes: attributes)
    }
}
