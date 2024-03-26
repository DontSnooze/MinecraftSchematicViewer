//
//  HopperBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/26/24.
//

import SceneKit

class HopperBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/hopper.scn") else {
            print("hopper scene is nil")
            return
        }
        
        let blockNodeName = attributes.facing == .down ? "hopper_block_down" : "hopper_block"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let topNode = blockNode.childNode(withName: "top", recursively: true),
            let middleNode = blockNode.childNode(withName: "middle", recursively: true),
            let bottomNode = blockNode.childNode(withName: "bottom", recursively: true),
            let insideNode = blockNode.childNode(withName: "inside", recursively: true)
        else {
            print("hopper node is nil")
            return
        }
        
        var topMaterials = [SCNMaterial]()
        var bottomMaterials = [SCNMaterial]()
        
        let sideImage = UIImage(named: "hopper_inside")
        let topImage = UIImage(named: "hopper_top")
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        let topNodeImages = [sideImage, sideImage, sideImage, sideImage, topImage, sideImage]
        let bottomNodesImages = [sideImage]
        
        for image in topNodeImages {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                topMaterials.append(material)
            }
        }
        
        for image in bottomNodesImages {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                bottomMaterials.append(material)
            }
        }
        
        if topMaterials.isEmpty {
            topNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            topNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            topNode.geometry?.firstMaterial?.isDoubleSided = true
            topNode.geometry?.materials = topMaterials
        }
        
        if bottomMaterials.isEmpty {
            middleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            middleNode.geometry?.firstMaterial?.transparency = 0.6
            
            bottomNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            bottomNode.geometry?.firstMaterial?.transparency = 0.6
            
            insideNode.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            insideNode.geometry?.firstMaterial?.transparency = 0.6
        } else {
            middleNode.geometry?.materials = bottomMaterials
            bottomNode.geometry?.materials = bottomMaterials
            insideNode.geometry?.materials = bottomMaterials
        }
        
        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
    }
}
