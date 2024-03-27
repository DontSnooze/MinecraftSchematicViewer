//
//  BambooBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class BambooBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let geometry = SCNBox(width: 0.17, height: 1.0, length: 0.17, chamferRadius: 0.01)
        let blockNode = SCNNode(geometry: geometry)
        
        let material = SCNMaterial()
        
        if let image = UIImage(named: "bamboo") {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        blockNode.geometry?.materials = [material]
        blockNode.name = attributes.name
        
        node.addChildNode(blockNode)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
