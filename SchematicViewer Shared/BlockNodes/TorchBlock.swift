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

//        node = parentNode.flattenedClone()
        node = parentNode
        applyAttributes()
    }
    
    func applyAttributes() {
        if attributes.name == "wall_torch" {
            node.applyDirectionAttribute(attributes: attributes)
        }
        
        if let flame = node.childNode(withName: "flame", recursively: true) {
            let material = SCNMaterial()
            var color = UIColor.fire
            if attributes.name.hasPrefix("soul") {
                color = .blue
            }
            if attributes.name.hasPrefix("redstone") {
                color = .red
            }
            
            material.diffuse.contents = color
            flame.geometry?.materials = [material]
        }
        
        node.name = attributes.name
        for child in node.childNodes {
            child.name = attributes.name
        }
    }
}
