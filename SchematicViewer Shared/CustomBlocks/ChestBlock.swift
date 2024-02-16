//
//  ChestBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

extension SCNNode {
    static func chestBlock() -> SCNNode {
        let frontImage = UIImage(named: "chest_front")
        let backImage = UIImage(named: "chest_back")
        let topImage = UIImage(named: "chest_top")
        
        let block = SceneBlock.sixImageBlock(frontImage: frontImage, rightImage: backImage, backImage: backImage, leftImage: backImage, topImage: topImage, bottomImage: topImage)
        
        block.name = "grass_block"
        
        return block
    }
}
