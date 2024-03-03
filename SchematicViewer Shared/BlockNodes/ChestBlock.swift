//
//  ChestBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

extension SCNNode {
    static func chestBlockFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        let frontImage = UIImage(named: "chest_front")
        let backImage = UIImage(named: "chest_back")
        let topImage = UIImage(named: "chest_top")
        
        let block = SCNNode.sixImageBlock(frontImage: backImage, rightImage: backImage, backImage: frontImage, leftImage: backImage, topImage: topImage, bottomImage: topImage)
        
        block.name = blockName
        
        block.applyAttributes(attributes: attributes)
        
        return block
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
    }
}
