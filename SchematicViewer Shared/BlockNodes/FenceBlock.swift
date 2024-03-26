//
//  FenceNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class FenceBlock: SVNode {
    
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var image: UIImage?
        // check for main image
        let fileName = attributes.name.replacingOccurrences(of: "_fence", with: "_planks")
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
        guard let scene = SCNScene(named: "Art.scnassets/fence.scn") else {
            print("scene is nil")
            return
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
            print("fence node is nil")
            return
        }
        
        let material = SCNMaterial()
        
        let resultNode = SCNNode()
        resultNode.addChildNode(centerNode)
        
        for direction in attributes.directions {
            switch direction {
            case .north:
                resultNode.addChildNode(northNode)
            case .south:
                resultNode.addChildNode(southNode)
            case .east:
                resultNode.addChildNode(eastNode)
            case .west:
                resultNode.addChildNode(westNode)
            default:
                break
            }
        }
        
        let flatNode = resultNode.flattenedClone()
        
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        flatNode.geometry?.materials = [material]
        node = flatNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
