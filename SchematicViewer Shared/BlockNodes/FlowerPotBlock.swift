//
//  FlowerPotBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//

import SceneKit

class FlowerPotBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var topImage: UIImage? {
        UIImage(named: "flower_pot_top")
    }
    var sideImage: UIImage? {
        UIImage(named: "flower_pot_side")
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let geometry = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.01)
        let blockNode = SCNNode(geometry: geometry)
        blockNode.position = SCNVector3(0, -0.249, 0)
        
        let topMaterial = SCNMaterial()
        let sideMaterial = SCNMaterial()
        
        if
            let tImage = topImage,
            let sImage = sideImage
        {
            topMaterial.diffuse.contents = tImage
            sideMaterial.diffuse.contents = sImage
            sideMaterial.isDoubleSided = true
            
            let materials = [sideMaterial, sideMaterial, sideMaterial, sideMaterial, topMaterial, sideMaterial]
            
            blockNode.geometry?.materials = materials
        } else {
            sideMaterial.diffuse.contents = UIColor.cyan
            sideMaterial.transparency = 0.6
            blockNode.geometry?.materials = [sideMaterial]
        }
        
        node.addChildNode(blockNode)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.childNodes.forEach {
            $0.name = attributes.name
        }
    }
}
