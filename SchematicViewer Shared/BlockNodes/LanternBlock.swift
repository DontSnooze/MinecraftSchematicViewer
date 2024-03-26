//
//  LanternBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class LanternBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let isSoulLantern = attributes.name == "soul_lantern"
        
        guard let scene = SCNScene(named: "Art.scnassets/lantern.scn") else {
            print("lantern scene is nil")
            return
        }
        
        let blockNodeName = isSoulLantern ? "soul_lantern" : "lantern"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("lantern node is nil")
            return
        }
        
        node = blockNode.flattenedClone()
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        let verticalMoveBy = attributes.isHanging ? 0.325 : -0.375
        node.runAction(SCNAction.moveBy(x: 0, y: verticalMoveBy, z: 0, duration: 0))
    }
}
