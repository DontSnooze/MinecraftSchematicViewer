//
//  HopperNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

extension SCNNode {
    static func hopperBlockFromName(blockName: String, isFacingDown: Bool = false) -> SCNNode {
        let block = SCNNode.hopperBlockNode(isFacingDown: isFacingDown)
        
        block.name = blockName
        
        return block
    }
    
    private static func hopperBlockNode(isFacingDown: Bool = false) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/hopper.scn") else {
            fatalError("scene is nil")
        }
        
        let blockNodeName = isFacingDown ? "hopper_block_down" : "hopper_block"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let topNode = blockNode.childNode(withName: "top", recursively: true),
            let middleNode = blockNode.childNode(withName: "middle", recursively: true),
            let bottomNode = blockNode.childNode(withName: "bottom", recursively: true),
            let insideNode = blockNode.childNode(withName: "inside", recursively: true)
        else {
            fatalError("hopper node is nil")
        }
        
        var topMaterials = [SCNMaterial]()
        var bottomMaterials = [SCNMaterial]()
        
        let sideImage = UIImage(named: "hopper_inside")
        let topImage = UIImage(named: "hopper_top")
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        let topNodeImages = [sideImage, sideImage, sideImage, sideImage, topImage, sideImage]
        let bottomNodesImages = [sideImage]
        
        for image in topNodeImages {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                topMaterials.append(material)
            }
        }
        
        for image in bottomNodesImages {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                bottomMaterials.append(material)
            }
        }
        
        if topMaterials.isEmpty {
            topNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            topNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            topNode.geometry?.firstMaterial?.isDoubleSided = true
            topNode.geometry?.materials = topMaterials
        }
        
        if bottomMaterials.isEmpty {
            middleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            middleNode.geometry?.firstMaterial?.transparency = 0.6
            
            bottomNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            bottomNode.geometry?.firstMaterial?.transparency = 0.6
            
            insideNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            insideNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            middleNode.geometry?.materials = bottomMaterials
            bottomNode.geometry?.materials = bottomMaterials
            insideNode.geometry?.materials = bottomMaterials
        }
        
        return blockNode
    }
}
