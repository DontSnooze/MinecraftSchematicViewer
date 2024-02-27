//
//  GenericBlockNode.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

extension SCNNode {
    static func blockFromName(blockName: String) -> SCNNode {
        var sideImage: UIImage?
        var topImage: UIImage?
        var bottomImage: UIImage?
        var frontImage: UIImage?
        var backImage: UIImage?

        // check for main image
        var fileName = blockName
        var hasAlternateImages = false

        if let image = UIImage(named: fileName) {
            sideImage = image
            topImage = image
            bottomImage = image
            frontImage = image
            backImage = image
        }

        // check for side image
        fileName = blockName + "_side"

        if let image = UIImage(named: fileName) {
            sideImage = image
            frontImage = image
            backImage = image
            hasAlternateImages = true
        }

        // check for top image
        fileName = blockName + "_top"
        
        if let image = UIImage(named: fileName) {
            topImage = image
            bottomImage = image
            hasAlternateImages = true
        }

        // check for bottom image
        fileName = blockName + "_bottom"
        
        if let image = UIImage(named: fileName) {
            bottomImage = image
            hasAlternateImages = true
        }

        // check for front image
        fileName = blockName + "_front"

        if let image = UIImage(named: fileName) {
            frontImage = image
            hasAlternateImages = true
        }

        // check for back image
        fileName = blockName + "_back"
        
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
        block.name = blockName
        
        return block
    }
    
    static func customBlock(blockId: Int) -> SCNNode? {
        var block: SCNNode?
        
        switch blockId {
        // water
        case 9:
            block = SCNNode.waterBlock()
        
        // grass dirt
        case 2:
            block = SCNNode.grassBlock()
            
        // chest
        case 54:
            block = SCNNode.chestBlock()
        default:
            return block
            
        }
        
        return block
    }
    
    static func customBlock(blockName: String) -> SCNNode? {
        var block: SCNNode?
        
        switch blockName {
        // water
        case "water":
            block = SCNNode.waterBlock()
        
        // grass dirt
        case "grass_block":
            block = SCNNode.grassBlock()
            
        // chest
        case "chest":
            block = SCNNode.chestBlock()
        default:
            return block
            
        }
        
        return block
    }
}
