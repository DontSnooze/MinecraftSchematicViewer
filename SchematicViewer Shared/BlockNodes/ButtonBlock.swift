//
//  ButtonBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/3/24.
//

import SceneKit

class ButtonBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/button.scn") else {
            print("button scene is nil")
            return
        }
        
        guard
            let buttonNode = scene.rootNode.childNode(withName: "button_node", recursively: true),
            let button = buttonNode.childNode(withName: "button", recursively: true)
        else {
            print("button node is nil")
            return
        }

        let material = SCNMaterial()
        if let image = buttonImage() {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        button.geometry?.materials = [material]
        button.name = attributes.name
        node = buttonNode
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        node.applyDirectionAttribute(attributes: attributes)
        
        switch attributes.face {
        case .ceiling:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            node.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .floor:
            let radial = CGFloat(GLKMathDegreesToRadians(-90))
            node.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        default:
            break
        }
    }
    
    func buttonImage() -> UIImage? {
        var image: UIImage?

        // check for image - wood or not
        let fileName = attributes.name.replacingOccurrences(of: "_button", with: "")

        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        } else if let fileImage = UIImage(named: "\(fileName)_planks") {
            image = fileImage
        }
        
        return image
    }
}
