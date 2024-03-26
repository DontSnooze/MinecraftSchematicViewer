//
//  SignBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

class SignBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var isWallSign: Bool {
        attributes.blockType == .wallSign
    }
    
    var blockImage: UIImage? {
        let suffix = isWallSign ? "_wall_sign" : "_sign"
        
        let fileName = attributes.name.replacingOccurrences(of: suffix, with: "_planks")

        return UIImage(named: fileName)
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/sign.scn") else {
            print("sign scene is nil")
            return
        }
        
        let blockNodeName = isWallSign ? "wall_sign_node" : "sign_node"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let signNode = blockNode.childNode(withName: "sign", recursively: true)
        else {
            print("sign node is nil")
            return
        }
        
        var materials = [SCNMaterial]()
        
        if let image = blockImage {
            let material = SCNMaterial()
            material.diffuse.contents = image
            materials.append(material)
        }
        
        if materials.isEmpty {
            signNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            signNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            signNode.geometry?.materials = materials
        }
        
        // don't flatten - flattening this node causes them not to render sometimes
        
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        if isWallSign {
            node.applyDirectionAttribute(attributes: attributes)
        }
    }
}
