//
//  GenericBlock.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

class GenericBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        var sideImage: UIImage?
        var topImage: UIImage?
        var bottomImage: UIImage?
        var frontImage: UIImage?
        var backImage: UIImage?

        // check for main image
        var fileName = attributes.name
        var hasAlternateImages = false

        if let image = UIImage(named: fileName) {
            sideImage = image
            topImage = image
            bottomImage = image
            frontImage = image
            backImage = image
        }

        // check for side image
        fileName = attributes.name + "_side"

        if let image = UIImage(named: fileName) {
            sideImage = image
            frontImage = image
            backImage = image
            hasAlternateImages = true
        }

        // check for top image
        fileName = attributes.name + "_top"
        
        if let image = UIImage(named: fileName) {
            topImage = image
            bottomImage = image
            hasAlternateImages = true
        }

        // check for bottom image
        fileName = attributes.name + "_bottom"
        
        if let image = UIImage(named: fileName) {
            bottomImage = image
            hasAlternateImages = true
        }

        // check for front image
        fileName = attributes.name + "_front"

        if let image = UIImage(named: fileName) {
            frontImage = image
            hasAlternateImages = true
        }

        // check for back image
        fileName = attributes.name + "_back"
        
        if let image = UIImage(named: fileName) {
            backImage = image
            hasAlternateImages = true
        }
        var block = SCNNode()
        
        if hasAlternateImages {
            block = SCNNode.sixImageBlock(frontImage: frontImage, rightImage: sideImage, backImage: backImage, leftImage: sideImage, topImage: topImage, bottomImage: bottomImage)
        } else {
            block = SCNNode.repeatedImageBlock(image: sideImage)
        }
        
        node = block
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
