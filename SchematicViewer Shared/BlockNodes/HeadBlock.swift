//
//  HeadBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class HeadBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        
        let geometry = SCNBox(width: 0.4, height: 0.4, length: 0.4, chamferRadius: 0.01)
        let head = SCNNode(geometry: geometry)
        head.name = "head"
        head.position = SCNVector3(0, -0.3, 0)
        
        node.addChildNode(head)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        guard let head = node.childNode(withName: "head", recursively: true) else {
            print("head node is nil")
            return
        }
        
        let material = SCNMaterial()
        
        if let image = UIImage(named: attributes.name) {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        head.geometry?.materials = [material]
        head.name = attributes.name
    }
}
