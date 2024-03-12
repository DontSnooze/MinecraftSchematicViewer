//
//  PistonHeadBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class PistonHeadBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/piston_head.scn") else {
            print("piston head scene is nil")
            return
        }
        
        guard
            let parentNode = scene.rootNode.childNode(withName: "piston_head", recursively: true),
            let headNode = parentNode.childNode(withName: "head", recursively: true)
        else {
            print("piston head node is nil")
            return
        }
        
        let material = SCNMaterial()
        var imageName = "piston_top"
        
        if attributes.name.hasPrefix("sticky") {
            imageName = "piston_top_sticky"
        }
        
        if let image = UIImage(named: imageName) {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        headNode.geometry?.materials = [material]
        
        applyAttributes(node: parentNode)
        
        node = parentNode.flattenedClone()
        node.name = attributes.name
    }
    
    func applyAttributes(node: SCNNode?) {
        node?.applyDirectionAttribute(attributes: attributes)
    }
    
    func applyAttributes() {}
}
