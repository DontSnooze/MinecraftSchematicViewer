//
//  WoodBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class WoodBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        var image: UIImage?
        // check for main image
        let fileName = attributes.name.replacingOccurrences(of: "_wood", with: "_log")
        
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        
        return image
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        node = SCNNode.repeatedImageBlock(image: blockImage)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
