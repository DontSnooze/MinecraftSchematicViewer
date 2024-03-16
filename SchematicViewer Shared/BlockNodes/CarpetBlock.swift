//
//  CarpetBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/11/24.
//

import SceneKit

class CarpetBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        
        let geometry = SCNBox(width: 1.0, height: 0.05, length: 1.0, chamferRadius: 0.01)
        let carpet = SCNNode(geometry: geometry)
        carpet.name = "carpet"
        carpet.position = SCNVector3(0, -0.47, 0)
        
        node.addChildNode(carpet)
        applyAttributes()
    }
    
    func applyAttributes() {
        guard let carpet = node.childNode(withName: "carpet", recursively: true) else {
            fatalError("carpet node is nil")
        }
        
        let name = attributes.name
        let colorString = name.replacingOccurrences(of: "_carpet", with: "")
        let material = SCNMaterial()
        
        if let color = UIColor.colorWith(name: colorString) {
            material.diffuse.contents = color
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        carpet.geometry?.materials = [material]
    }
}
