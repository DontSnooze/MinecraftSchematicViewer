//
//  LadderBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class LadderBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        UIImage(named: attributes.name)
    }
    
    init(attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let geometry = SCNPlane(width: 1.0, height: 1.0)
        let ladder = SCNNode(geometry: geometry)
        ladder.position = SCNVector3(0, 0, 0.46)
        
        let material = SCNMaterial()
        
        if let image = blockImage {
            material.diffuse.contents = image
            material.isDoubleSided = true
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        ladder.geometry?.materials = [material]
        ladder.name = attributes.name
        node.addChildNode(ladder)
        
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
}
