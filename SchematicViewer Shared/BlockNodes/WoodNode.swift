//
//  WoodNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func woodBlockFromName(blockName: String) -> SCNNode {
        var image: UIImage?
        // check for main image
        let fileName = blockName.replacingOccurrences(of: "_wood", with: "_log")
        
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        
        let block = woodBlockNode(image: image)
        
        block.name = blockName
        
        return block
    }
    
    static func woodBlockNode(image: UIImage?) -> SCNNode {
        return repeatedImageBlock(image: image)
    }
}
