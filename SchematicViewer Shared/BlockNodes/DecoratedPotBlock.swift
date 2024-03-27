//
//  DecoratedPotBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/27/24.
//
import SceneKit

class DecoratedPotBlock: SVNode {
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
    
    func applyAttributes() {
        node.name = attributes.name
        node.childNodes.forEach {
            $0.name = attributes.name
        }
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/pot.scn") else {
            print("pot scene is nil")
            return
        }
        
        guard
            let parentNode = scene.rootNode.childNode(withName: "pot", recursively: true),
            let topNode = parentNode.childNode(withName: "top", recursively: true),
            let bottomNode = parentNode.childNode(withName: "bottom", recursively: true)
        else {
            print("pot node is nil")
            return
        }
        
        // setup bottom half
        let material = SCNMaterial()
        if let image = sideImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        bottomNode.geometry?.materials = [material]
        
        // setup top half
        let topMaterial = SCNMaterial()
        let sideMaterial = SCNMaterial()
        let bottomMaterial = SCNMaterial()
        
        if
            let tImage = topImage,
            let sImage = sideImage
        {
            topMaterial.diffuse.contents = tImage
            sideMaterial.diffuse.contents = sImage
            sideMaterial.isDoubleSided = true
            bottomMaterial.isDoubleSided = true
            bottomMaterial.diffuse.contents = UIColor.black
            
            let materials = [sideMaterial, sideMaterial, sideMaterial, sideMaterial, topMaterial, bottomMaterial]
            
            topNode.geometry?.materials = materials
        } else {
            sideMaterial.diffuse.contents = UIColor.cyan
            sideMaterial.transparency = 0.6
            topNode.geometry?.materials = [sideMaterial]
        }
        
        node = parentNode
        applyAttributes()
    }
}
