//
//  FenceGateNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func fenceGateNodeFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        var image: UIImage?

        // check for image - wood or not
        let fileName = blockName.replacingOccurrences(of: "_fence_gate", with: "")

        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }

        let block = fenceGateNode(image: image, isOpen: attributes.isOpen)
        
        block.name = blockName
        
        block.applyAttributes(attributes: attributes)
        
        return block
    }
    
    private static func fenceGateNode(image: UIImage?, isOpen: Bool = false) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/fence_gate.scn") else {
            fatalError("scene is nil")
        }
        
        let nodeName = isOpen ? "fence_gate_node_open" : "fence_gate_node"
        
        guard
            let node = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let fenceGate = node.childNode(withName: "fence_gate", recursively: true)
        else {
            fatalError("button node is nil")
        }

        let material = SCNMaterial()
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        fenceGate.geometry?.materials = [material]
        
        return node
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
    }
}
