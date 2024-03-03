//
//  DoorNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func doorNodeFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        
        var image: UIImage?
        
        // check for image - wood or not
        let imageSuffix = attributes.halfType == .upper ? "_top" : "_bottom"
        
        let fileName = blockName.appending(imageSuffix)
        
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        
        let block = SCNNode.doorNode(image: image)
        
        block.name = blockName
        
        block.applyAttributes(attributes: attributes)
        
        return block
    }
    
    private static func doorNode(image: UIImage?) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/door.scn") else {
            fatalError("scene is nil")
        }
        
        let nodeName = "door_node"
        
        guard
            let node = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let door = node.childNode(withName: "door", recursively: true)
        else {
            fatalError("button node is nil")
        }

        let material = SCNMaterial()
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        door.geometry?.materials = [material]
        
        return node
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
    }
}
