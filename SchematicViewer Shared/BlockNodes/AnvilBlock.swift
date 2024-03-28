//
//  AnvilBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class AnvilBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        UIImage(named: "anvil")
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/anvil.scn") else {
            print("anvil scene is nil")
            return
        }
        
        guard let anvilNode = scene.rootNode.childNode(withName: "anvil", recursively: true) else {
            print("anvil node is nil")
            return
        }
        
        // setup bottom half
        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        anvilNode.geometry?.materials = [material]
        
        node = anvilNode
        applyAttributes()
    }
}
