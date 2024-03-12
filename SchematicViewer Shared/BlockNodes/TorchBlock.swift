//
//  Torch.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class TorchBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/torch.scn") else {
            print("torch scene is nil")
            return
        }
        
        guard let parentNode = scene.rootNode.childNode(withName: attributes.name, recursively: true) else {
            print("torch node is nil")
            return
        }
        
        if attributes.name == "wall_torch" {
            applyAttributes(node: parentNode)
        }

        node = parentNode.flattenedClone()
        node.name = attributes.name
    }
    
    func applyAttributes(node: SCNNode?) {
        node?.applyDirectionAttribute(attributes: attributes)
        
        guard let flame = node?.childNode(withName: "flame", recursively: true) else {
            print("flame node is nil")
            return
        }
        
        let material = SCNMaterial()
        var color = UIColor.fire
        if attributes.name.hasPrefix("soul") {
            color = .blue
        }
        
        material.diffuse.contents = color
        flame.geometry?.materials = [material]
    }
    
    func applyAttributes() {}
}
