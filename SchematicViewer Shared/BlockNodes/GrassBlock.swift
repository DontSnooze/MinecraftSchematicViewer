//
//  GrassBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

class GrassBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard
            let sideImage = UIImage(named: "grass_side"),
            let topImage = UIImage(named: "grass_top"),
            let bottomImage = UIImage(named: "dirt")
        else {
            node = SCNNode.createBlock()
            return
        }
        
        node = SCNNode.sixImageBlock(pxImage: sideImage, nxImage: sideImage, pyImage: topImage, nyImage: bottomImage, pzImage: sideImage, nzImage: sideImage)
        
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
