//
//  LecternBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class LecternBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var topImage: UIImage? {
        UIImage(named: "lectern_top")
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
        guard let scene = SCNScene(named: "Art.scnassets/lectern.scn") else {
            print("lectern scene is nil")
            return
        }
        
        guard let lecturnNode = scene.rootNode.childNode(withName: "lectern", recursively: true) else {
            print("lectern node is nil")
            return
        }
        
        // setup bottom half
        let material = SCNMaterial()
        if let image = topImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        lecturnNode.geometry?.materials = [material]
        
        node = lecturnNode
        applyAttributes()
    }
}
