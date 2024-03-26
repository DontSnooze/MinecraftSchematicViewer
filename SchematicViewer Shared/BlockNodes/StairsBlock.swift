//
//  StairsNode.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//

import SceneKit

class StairsBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var image: UIImage?

        // check for image - wood or not
        let fileName = attributes.name.replacingOccurrences(of: "_stairs", with: "")

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
        guard let stairsScene = SCNScene(named: "Art.scnassets/stairs.scn") else {
            fatalError("scene is nil")
        }
        
        guard
            let stairsBlockNode = stairsScene.rootNode.childNode(withName: "stairs", recursively: true),
            let stairsTopNode = stairsBlockNode.childNode(withName: "stairs_top", recursively: true),
            let stairsSlabNode = stairsBlockNode.childNode(withName: "stairs_slab", recursively: true)
        else {
            fatalError("stairs node is nil")
        }

        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        stairsSlabNode.geometry?.materials = [material]
        stairsTopNode.geometry?.materials = [material]
        
        node = stairsBlockNode
        
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        
        switch attributes.halfType {
        case .top:
            let radial = GLKMathDegreesToRadians(180)
            node.runAction(SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(radial), duration: 0))
        default:
            break
        }
        
        switch attributes.facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            node.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            let radial = GLKMathDegreesToRadians(-90)
            node.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            node.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let degrees: Float = attributes.halfType == .bottom ? -90 : 90
            let radial = GLKMathDegreesToRadians(degrees)
            node.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let degrees: Float = attributes.halfType == .bottom ? 90 : -90
            let radial = GLKMathDegreesToRadians(degrees)
            node.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
}
