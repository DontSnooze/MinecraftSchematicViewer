//
//  SignNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

extension SCNNode {
    static func signBlockFromName(blockName: String, isWallSign: Bool = false) -> SCNNode {
        // check for main image
        let suffix = isWallSign ? "_wall_sign" : "_sign"
        
        let fileName = blockName.replacingOccurrences(of: suffix, with: "_planks")

        let image = UIImage(named: fileName)
        let block = SCNNode.signBlockNode(image: image, isWallSign: isWallSign)
        
        block.name = blockName
        
        return block
    }
    
    static func signBlockNode(image: UIImage?, isWallSign: Bool = false) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/sign.scn") else {
            fatalError("scene is nil")
        }
        
        let blockNodeName = isWallSign ? "wall_sign_block" : "sign_block"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let signNode = blockNode.childNode(withName: "sign", recursively: true)
        else {
            fatalError("sign node is nil")
        }
        
        var materials = [SCNMaterial]()
        
        if let image = image {
            let material = SCNMaterial()
            material.diffuse.contents = image
            materials.append(material)
        }
        
        if materials.isEmpty {
            signNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            signNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            signNode.geometry?.materials = materials
        }
        return blockNode
    }
}
