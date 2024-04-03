//
//  Vine.swift
//  SchematicViewer
//
//  Created by Amos Todman on 4/3/24.
//

import SceneKit

class VineBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        UIImage(named: "green_vine")
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
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/vine.scn") else {
            print("vine scene is nil")
            return
        }
        
        let nodeName = "vine"
        
        guard
            let parentNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let topNode = parentNode.childNode(withName: "top", recursively: true),
            let northNode = parentNode.childNode(withName: "north", recursively: true),
            let southNode = parentNode.childNode(withName: "south", recursively: true),
            let eastNode = parentNode.childNode(withName: "east", recursively: true),
            let westNode = parentNode.childNode(withName: "west", recursively: true)
        else {
            print("vine node is nil")
            return
        }
        
        let resultNode = SCNNode()
        
        for direction in attributes.directions {
            switch direction {
            case .up:
                resultNode.addChildNode(topNode)
            case .north:
                resultNode.addChildNode(northNode)
            case .south:
                resultNode.addChildNode(southNode)
            case .east:
                resultNode.addChildNode(eastNode)
            case .west:
                resultNode.addChildNode(westNode)
            default:
                break
            }
        }
        
        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
            material.isDoubleSided = true
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        for childNode in resultNode.childNodes {
            childNode.geometry?.materials = [material]
        }
        
        node = resultNode
        applyAttributes()
    }
}
