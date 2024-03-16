//
//  DoorNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class DoorBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/door.scn") else {
            print("door scene is nil")
            return
        }
        
        let nodeName = "door_node"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let door = blockNode.childNode(withName: "door", recursively: true)
        else {
            print("door node is nil")
            return
        }

        let material = SCNMaterial()
        if let image = doorImage() {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        door.geometry?.materials = [material]
        door.name = attributes.name
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
    
    func doorImage() -> UIImage? {
        var image: UIImage?
        
        // check for image - wood or not
        let imageSuffix = attributes.halfType == .upper ? "_top" : "_bottom"
        
        let fileName = attributes.name.appending(imageSuffix)
        
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        
        return image
    }
}
