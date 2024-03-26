//
//  LeverBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class LeverBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/lever.scn") else {
            print("lever scene is nil")
            return
        }
        
        let blockNodeName = "lever_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("lever node is nil")
            return
        }
        
        node = blockNode.flattenedClone()
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
        
        switch attributes.face {
        case .ceiling:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            node.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .floor:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            node.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        default:
            break
        }
    }
}
