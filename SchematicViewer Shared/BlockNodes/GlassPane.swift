//
//  GlassPane.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/26/24.
//

import SceneKit

extension SCNNode {
    static func glassPaneBlockFromName(blockName: String, directions: [NodeBlock.Direction] = []) -> SCNNode {
        
        var image: UIImage?
        // check for main image
        let fileName = blockName.replacingOccurrences(of: "_pane", with: "")
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        let block = SCNNode.glassPaneBlockNode(directions: directions, image: image)
        
        block.name = blockName
        
        return block
    }
    
    static func glassPaneBlockNode(directions: [NodeBlock.Direction] = [], image: UIImage?) -> SCNNode {
        
        // check for full length panes
        if directions.count == 2 {
            if
                directions.contains(.east),
                directions.contains(.west)
            {
                return fullGlassPaneBlockNode(facing: .north, image: image)
            }
            
            if
                directions.contains(.north),
                directions.contains(.south)
            {
                return fullGlassPaneBlockNode(facing: .west, image: image)
            }
        }
        
        guard let scene = SCNScene(named: "Art.scnassets/glass_pane.scn") else {
            fatalError("scene is nil")
        }
        
        let blockNodeName = "glass_pane_block"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let centerNode = blockNode.childNode(withName: "center", recursively: true),
            let northNode = blockNode.childNode(withName: "north", recursively: true),
            let southNode = blockNode.childNode(withName: "south", recursively: true),
            let eastNode = blockNode.childNode(withName: "east", recursively: true),
            let westNode = blockNode.childNode(withName: "west", recursively: true)
        else {
            fatalError("glass pane node is nil")
        }
        
        let nodes = [
            centerNode,
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
        
        if directions.isEmpty || directions.contains(.none) {
            centerNode.isHidden = false
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
    
    static func fullGlassPaneBlockNode(facing: NodeBlock.Direction, image: UIImage?) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/glass_pane.scn") else {
            fatalError("scene is nil")
        }

        let blockNodeName = facing == .north ? "full_glass_pane_north" : "full_glass_pane_west"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("glass pane node is nil")
        }
        
        let material = SCNMaterial()
        
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        blockNode.geometry?.materials = [material]
        
        return blockNode
    }
}
