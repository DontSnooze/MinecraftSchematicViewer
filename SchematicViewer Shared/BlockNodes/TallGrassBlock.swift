//
//  TallGrassBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/26/24.
//

import SceneKit

class TallGrassBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        let imageName = attributes.halfType == .upper ? "tall_grass_top" : "tall_grass_bottom"
        return UIImage(named: imageName)
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        node = SCNNode.spriteBlock(image: blockImage, name: attributes.name)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
