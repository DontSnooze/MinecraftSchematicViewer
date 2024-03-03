//
//  ButtonBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

extension SCNNode {
    static func buttonBlockFromName(blockName: String, attributes: NodeBlockAttributes) -> SCNNode {
        var image: UIImage?

        // check for image - wood or not
        let fileName = blockName.replacingOccurrences(of: "_button", with: "")

        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }

        let block = buttonBlock(image: image)
        
        block.name = blockName
        
        block.applyAttributes(attributes: attributes)
        
        return block
    }
    
    private static func buttonBlock(image: UIImage?) -> SCNNode {
        guard let scene = SCNScene(named: "Art.scnassets/button.scn") else {
            fatalError("scene is nil")
        }
        
        guard
            let buttonNode = scene.rootNode.childNode(withName: "button_node", recursively: true),
            let button = buttonNode.childNode(withName: "button", recursively: true)
        else {
            fatalError("button node is nil")
        }

        let material = SCNMaterial()
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        button.geometry?.materials = [material]
        
        return buttonNode
    }
    
    private func applyAttributes(attributes: NodeBlockAttributes) {
        applyDirectionAttribute(attributes: attributes)
        
        switch attributes.face {
        case .ceiling:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .floor:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        default:
            break
        }
    }
}
