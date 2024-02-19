//
//  GrassBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

extension SCNNode {
    static func grassBlock() -> SCNNode {
        guard
            let sideImage = UIImage(named: "grass_side"),
            let topImage = UIImage(named: "grass_top"),
            let bottomImage = UIImage(named: "dirt")
        else {
            return SCNNode.createBlock()
        }
        
        let block = SCNNode.sixImageBlock(pxImage: sideImage, nxImage: sideImage, pyImage: topImage, nyImage: bottomImage, pzImage: sideImage, nzImage: sideImage)
        
        block.name = "grass_block"
        
        return block
    }
}
