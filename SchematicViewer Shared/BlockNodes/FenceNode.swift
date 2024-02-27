//
//  FenceNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func fenceBlockFromName(blockName: String, directions: [NodeBlockAttributes.Direction] = []) -> SCNNode {
        
        var image: UIImage?
        // check for main image
        let fileName = blockName.replacingOccurrences(of: "_fence", with: "_planks")
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        let block = SCNNode.fenceBlockNode(directions: directions, image: image)
        
        block.name = blockName
        
        return block
    }
    
    static func fenceBlockNode(directions: [NodeBlockAttributes.Direction] = [], image: UIImage?) -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/fence.scn") else {
            fatalError("scene is nil")
        }
        
        let blockNodeName = "fence_node"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let centerNode = blockNode.childNode(withName: "center", recursively: true),
            let northNode = blockNode.childNode(withName: "north", recursively: true),
            let southNode = blockNode.childNode(withName: "south", recursively: true),
            let eastNode = blockNode.childNode(withName: "east", recursively: true),
            let westNode = blockNode.childNode(withName: "west", recursively: true)
        else {
            fatalError("fence node is nil")
        }
        
        var nodes = [
            northNode,
            southNode,
            eastNode,
            westNode
        ]
        
        let material = SCNMaterial()
        
        // hide all nodes
        for node in nodes {
            node.isHidden = true
        }
        
        if directions.contains(.north) {
            northNode.isHidden = false
        }
        
        if directions.contains(.south) {
            southNode.isHidden = false
        }
        
        if directions.contains(.east) {
            eastNode.isHidden = false
        }
        
        if directions.contains(.west) {
            westNode.isHidden = false
        }
        
        nodes.append(centerNode)
        
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        for node in (nodes.filter { !$0.isHidden }) {
            node.geometry?.materials = [material]
        }
        
        return blockNode
    }
}
