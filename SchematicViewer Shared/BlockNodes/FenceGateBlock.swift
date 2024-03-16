//
//  FenceGateNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class FenceGateBlock: SVNode {
    
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var image: UIImage?

        // check for image - wood or not
        let fileName = attributes.name.replacingOccurrences(of: "_fence_gate", with: "")

        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }
        return image
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/fence_gate.scn") else {
            print("scene is nil")
            return
        }
        
        let nodeName = attributes.isOpen ? "fence_gate_node_open" : "fence_gate_node"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let fenceGate = blockNode.childNode(withName: "fence_gate", recursively: true)
        else {
            print("button node is nil")
            return
        }

        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        fenceGate.geometry?.materials = [material]
        fenceGate.name = attributes.name
        
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.applyDirectionAttribute(attributes: attributes)
    }
}
