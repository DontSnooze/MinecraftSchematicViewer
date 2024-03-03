//
//  RailNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func railBlockFromName(blockName: String, isPowered: Bool = false, shape: NodeBlockAttributes.Shape = .none) -> SCNNode {
        
        let cornerShapes: [NodeBlockAttributes.Shape] = [
            .north_east, .north_west, .south_east, .south_west
        ]
        let isCorner = cornerShapes.contains(shape)
        
        var image: UIImage?
        var imageName = "rail"
        
        switch blockName {
        case "activator_rail",
            "detector_rail",
            "powered_rail":
            imageName = isPowered ? "\(blockName)_on" : blockName
        case "rail":
            imageName = isCorner ? "\(blockName)_corner" : blockName
        default:
            break
        }

        if let fileImage = UIImage(named: imageName) {
            image = fileImage
        }

        let block = railBlock(image: image)
        
        block.name = blockName
        
        return block
    }
    
    private static func railBlock(image: UIImage?) -> SCNNode {
        guard let railScene = SCNScene(named: "Art.scnassets/rail.scn") else {
            fatalError("rail scene is nil")
        }
        
        guard
            let railParentNode = railScene.rootNode.childNode(withName: "rail_node", recursively: true),
            let railNode = railParentNode.childNode(withName: "rail", recursively: true)
        else {
            fatalError("rail node is nil")
        }

        let material = SCNMaterial()
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        railNode.geometry?.materials = [material]
        
        return railParentNode
    }
}
