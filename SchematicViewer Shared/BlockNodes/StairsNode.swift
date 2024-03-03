//
//  StairsNode.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

extension SCNNode {
    static func stairsBlockFromName(blockName: String, halfType: NodeBlockAttributes.HalfType = .bottom) -> SCNNode {
        var image: UIImage?

        // check for image - wood or not
        let fileName = blockName.replacingOccurrences(of: "_stairs", with: "")

        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }

        let block = stairsBlock(image: image)
        
        block.name = blockName
        
        return block
    }
    
    private static func stairsBlock(image: UIImage?) -> SCNNode {
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

        let material = SCNMaterial()
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        stairsSlabNode.geometry?.materials = [material]
        stairsTopNode.geometry?.materials = [material]
        
        return stairsBlockNode
    }
}
