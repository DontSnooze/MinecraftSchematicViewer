//
//  RailBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class RailBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        let cornerShapes: [NodeBlockAttributes.Shape] = [
            .north_east, .north_west, .south_east, .south_west
        ]
        let isCorner = cornerShapes.contains(attributes.shape)
        
        var image: UIImage?
        var imageName = "rail"
        
        switch attributes.name {
        case "activator_rail",
            "detector_rail",
            "powered_rail":
            imageName = attributes.isPowered ? "\(attributes.name)_on" : attributes.name
        case "rail":
            imageName = isCorner ? "\(attributes.name)_corner" : attributes.name
        default:
            break
        }

        if let fileImage = UIImage(named: imageName) {
            image = fileImage
        }
        
        return image
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let railScene = SCNScene(named: "Art.scnassets/rail.scn") else {
            print("rail scene is nil")
            return
        }
        
        guard
            let blockNode = railScene.rootNode.childNode(withName: "rail_node", recursively: true),
            let railNode = blockNode.childNode(withName: "rail", recursively: true)
        else {
            print("rail node is nil")
            return
        }

        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        railNode.geometry?.materials = [material]
        
        node = blockNode.flattenedClone()
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        switch attributes.shape {
        case .north_east:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            node.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .north_west:
            let radial = CGFloat(GLKMathDegreesToRadians(180))
            node.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .south_east:
            // default
            break
        case .south_west:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            node.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .east_west:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            node.runAction(SCNAction.rotateBy(x: 0, y: radial, z: 0, duration: 0))
        case .north_south:
            // default
            break
        default:
            break
        }
    }
}
