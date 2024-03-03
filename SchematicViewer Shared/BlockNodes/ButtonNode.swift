//
//  Button.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class ButtonNode: SCNNode {
    var attributes: NodeBlockAttributes
    var blockName = ""
    var blockAttributeString = ""
    
    init(name: String, attributes: NodeBlockAttributes) {
        self.attributes = attributes
        self.blockName = name
        
        guard let scene = SCNScene(named: "Art.scnassets/button.scn") else {
            fatalError("button scene is nil")
        }
        
        let blockNodeName = "button_node"
        
        guard let node = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("lever node is nil")
        }
        
        super.init()
        
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/button.scn") else {
            fatalError("button scene is nil")
        }
        
        let blockNodeName = "button_node"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("lever node is nil")
        }
    }
    
    func applyAttributes() {
        applyDirectionAttribute(attributes: attributes)
        
        switch attributes.face {
        case .ceiling:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .floor:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        default:
            break
        }
    }
}
