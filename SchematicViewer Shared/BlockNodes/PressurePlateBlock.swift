//
//  PressurePlateBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class PressurePlateBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var image: UIImage?

        var fileName = attributes.name.replacingOccurrences(of: "_pressure_plate", with: "")
        if fileName == "light_weighted" {
            fileName = "gold_block"
        }
        
        if fileName == "heavy_weighted" {
            fileName = "iron_block"
        }

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
        let geometry = SCNBox(width: 0.9, height: 0.05, length: 0.9, chamferRadius: 0.01)
        let plateNode = SCNNode(geometry: geometry)
        plateNode.name = "pressure_plate"
        plateNode.position = SCNVector3(0, -0.47, 0)
        
        let material = SCNMaterial()
        
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        plateNode.geometry?.materials = [material]
        
        node.addChildNode(plateNode)
        
        applyAttributes()
    }
    
    func applyAttributes() {
        guard let plateNode = node.childNode(withName: "pressure_plate", recursively: true) else {
            print("pressure plate node is nil")
            return
        }
    
        node.name = attributes.name
        plateNode.name = attributes.name
    }
}
