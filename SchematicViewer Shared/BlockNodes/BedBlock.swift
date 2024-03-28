//
//  BedBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class BedBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var bedColor: UIColor? {
        let colorString = attributes.name.replacingOccurrences(of: "_bed", with: "")
        return UIColor.colorWith(name: colorString)
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
        guard let scene = SCNScene(named: "Art.scnassets/bed.scn") else {
            print("bed scene is nil")
            return
        }
        
        let nodeName = attributes.part == .head ? "bed_head" : "bed_foot"
        
        guard
            let parentNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let mattress = parentNode.childNode(withName: "mattress", recursively: true)
        else {
            print("bed node is nil")
            return
        }
        
        // setup bottom half
        let material = SCNMaterial()
        if let color = bedColor {
            material.diffuse.contents = color
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        mattress.geometry?.materials = [material]
        
        node = parentNode
        applyAttributes()
    }
}
