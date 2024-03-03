//
//  LanternNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

extension SCNNode {
    static func lanternBlockFromName(blockName: String, isHanging: Bool = false) -> SCNNode {
        
        let isSoulLantern = blockName == "soul_lantern"
        let block = SCNNode.lanternBlockNode(isSoulLantern: isSoulLantern, isHanging: isHanging)
        
        block.name = blockName
        
        return block
    }
    
    private static func lanternBlockNode(isSoulLantern: Bool = false, isHanging: Bool = false) -> SCNNode {
        
        guard let scene = SCNScene(named: "Art.scnassets/lantern.scn") else {
            fatalError("lantern scene is nil")
        }
        
        let blockNodeName = isSoulLantern ? "soul_lantern" : "lantern"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            fatalError("fence node is nil")
        }
        
        return blockNode
    }
}
