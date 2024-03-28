//
//  GrindstoneBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class GrindstoneBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        UIImage(named: "grindstone_side")
    }
    
    var legsImage: UIImage? {
        UIImage(named: "dark_oak_planks")
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.childNodes.forEach {
            $0.name = attributes.name
        }
        node.applyDirectionAttribute(attributes: attributes)
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/grindstone.scn") else {
            print("grindstone scene is nil")
            return
        }
        
        guard
            let blockNode = scene.rootNode.childNode(withName: "grindstone", recursively: true),
            let middleNode = blockNode.childNode(withName: "middle", recursively: true),
            let legsNode = blockNode.childNode(withName: "legs", recursively: true)
        else {
            print("grindstone node is nil")
            return
        }
        
        // setup middle
        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        middleNode.geometry?.materials = [material]
        
        // setup legs
        let legsMaterial = SCNMaterial()
        if let image = legsImage {
            legsMaterial.diffuse.contents = image
        } else {
            legsMaterial.diffuse.contents = UIColor.cyan
            legsMaterial.transparency = 0.6
        }
        
        legsNode.geometry?.materials = [legsMaterial]
        
        node = blockNode
        applyAttributes()
    }
}
