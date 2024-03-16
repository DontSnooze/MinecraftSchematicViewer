//
//  ChestBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SceneKit

class ChestBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let frontImage = UIImage(named: "chest_front")
        let backImage = UIImage(named: "chest_back")
        let topImage = UIImage(named: "chest_top")
        
        node = SCNNode.sixImageBlock(frontImage: backImage, rightImage: backImage, backImage: frontImage, leftImage: backImage, topImage: topImage, bottomImage: topImage)
        
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
}
