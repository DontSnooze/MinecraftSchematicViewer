//
//  WaterBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

class WaterBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.05)
        
        let block = SCNNode(geometry: g)
        
        block.geometry?.firstMaterial?.transparency = 0.70
        block.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        node = block
        applyAttributes()
    }
    
    func applyAttributes() {
        // node.name = "water_block"
        node.name = attributes.name
    }
}
