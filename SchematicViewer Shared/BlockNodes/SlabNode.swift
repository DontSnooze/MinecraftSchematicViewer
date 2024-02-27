//
//  SlabNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func slabBlockFromName(blockName: String) -> SCNNode {
        guard blockName != "smooth_stone_slab" else {
            return smoothStoneSlabBlockNode()
        }
        
        var image: UIImage?
        // check for main image
        let fileName = blockName.replacingOccurrences(of: "_slab", with: "")
        
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }
        
        let block = slabBlockNode(image: image)
        
        block.name = blockName
        
        return block
    }
    
    static func slabBlockNode(image: UIImage?) -> SCNNode {
        return repeatedImageBlock(image: image)
    }
    
    static func smoothStoneSlabBlockNode() -> SCNNode {
        let sideImage = UIImage(named: "smooth_stone_slab_side")
        let topImage = UIImage(named: "smooth_stone")
        
        let blockNode = sixImageBlock(frontImage: sideImage, rightImage: sideImage, backImage: sideImage, leftImage: sideImage, topImage: topImage, bottomImage: topImage)
        
        return blockNode
    }
}
