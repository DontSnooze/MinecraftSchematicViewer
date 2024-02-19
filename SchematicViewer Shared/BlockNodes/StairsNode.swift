//
//  StairsNode.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

extension SCNNode {
    static func stairsBlockFromName(blockName: String, halfType: NodeBlock.HalfType = .bottom) -> SCNNode {
        var sideImage: UIImage?
        var topImage: UIImage?
        var bottomImage: UIImage?
        var frontImage: UIImage?
        var backImage: UIImage?

        // check for main image
        var fileName = blockName.replacingOccurrences(of: "_stairs", with: "")

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
        }

        // check for top image
        fileName = blockName + "_top"
        
        if let image = UIImage(named: fileName) {
            topImage = image
            bottomImage = image
        }

        // check for bottom image
        fileName = blockName + "_bottom"
        
        if let image = UIImage(named: fileName) {
            bottomImage = image
        }

        // check for front image
        fileName = blockName + "_front"

        if let image = UIImage(named: fileName) {
            frontImage = image
        }

        // check for back image
        fileName = blockName + "_back"
        
        if let image = UIImage(named: fileName) {
            backImage = image
        }

        let block = stairsBlock(frontImage: frontImage, rightImage: sideImage, backImage: backImage, leftImage: sideImage, topImage: topImage, bottomImage: bottomImage)
        
        block.name = blockName
        
        return block
    }
    
    static func stairsBlock(frontImage: UIImage?,
                            rightImage: UIImage?,
                            backImage: UIImage?,
                            leftImage: UIImage?,
                            topImage: UIImage?,
                            bottomImage: UIImage?) -> SCNNode {
        guard let stairsScene = SCNScene(named: "Art.scnassets/stairs.scn") else {
            fatalError("scene is nil")
        }
        
        guard
            let stairsBlockNode = stairsScene.rootNode.childNode(withName: "stairs", recursively: true),
            let stairsTopNode = stairsBlockNode.childNode(withName: "stairs_top", recursively: true),
            let stairsSlabNode = stairsBlockNode.childNode(withName: "stairs_slab", recursively: true)
        else {
            fatalError("stairs node is nil")
        }
        
        var materials = [SCNMaterial]()
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        let images = [frontImage, rightImage, backImage, leftImage, topImage, bottomImage]
        
        for image in images {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                materials.append(material)
            }
        }
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        if materials.isEmpty {
            stairsSlabNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            stairsSlabNode.geometry?.firstMaterial?.transparency = 0.6
            
            stairsTopNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            stairsTopNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            stairsSlabNode.geometry?.materials = materials
            stairsTopNode.geometry?.materials = materials
        }
        return stairsBlockNode
    }
}
