//
//  WaterBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

extension SCNNode {
    static func waterBlock() -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.05)
        
        let block = SCNNode(geometry: g)
        
        block.name = "water_block"
        block.geometry?.firstMaterial?.transparency = 0.70
        block.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        return block
    }
}
