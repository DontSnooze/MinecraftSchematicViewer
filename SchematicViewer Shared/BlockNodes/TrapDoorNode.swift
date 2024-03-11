//
//  TrapDoorNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/11/24.
//

import SceneKit

class TrapDoorNode: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let geometry = SCNBox(width: 1.0, height: 0.2, length: 1.0, chamferRadius: 0.01)
        let trapDoor = SCNNode(geometry: geometry)
        trapDoor.position = SCNVector3(0, -0.4, 0)
        
        let material = SCNMaterial()
        if let image = UIImage(named: attributes.name) {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        trapDoor.geometry?.materials = [material]
        trapDoor.name = attributes.name
        node.addChildNode(trapDoor)
        
        applyAttributes()
    }
    
    func applyAttributes() {
        if attributes.halfType == .top {
            let radial = GLKMathDegreesToRadians(180)
            node.runAction(SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(radial), duration: 0))
        }
    
        node.applyDirectionAttribute(attributes: attributes)
        
        if attributes.isOpen {
            let nodeAttributes = NodeBlockAttributes(with: "", attributesString: "facing=down")
            node.applyDirectionAttribute(attributes: nodeAttributes)
        }
    }
}
