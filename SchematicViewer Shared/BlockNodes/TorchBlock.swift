//
//  Torch.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class TorchBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        let imageName = attributes.name.replacingOccurrences(of: "wall_torch", with: "torch")
        return UIImage(named: imageName)
    }
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        let blockNode = SCNNode.spriteBlock(image: blockImage, name: attributes.name)

        node = blockNode
        applyAttributes()
    }
    
    func applyAttributes() {
        if attributes.name == "wall_torch" {
            applyDirectionAttributes()
        }
        
        node.name = attributes.name
    }
    
    func applyDirectionAttributes() {
        let container = SCNNode()
        let currentNode = node
        
        var radial = GLKMathDegreesToRadians(-22)
        currentNode.position = SCNVector3(0, 0.25, 0.3)
        currentNode.eulerAngles = SCNVector3Make(radial, 0, 0)
        container.addChildNode(currentNode)
        
        switch attributes.facing {
        case .north:
            // default
            break
        case .south:
            radial = GLKMathDegreesToRadians(180)
            container.eulerAngles = SCNVector3Make(0, radial, 0)
        case .east:
            radial = GLKMathDegreesToRadians(-90)
            container.eulerAngles = SCNVector3Make(0, radial, 0)
        case .west:
            radial = GLKMathDegreesToRadians(90)
            container.eulerAngles = SCNVector3Make(0, radial, 0)
        default:
            break
        }
        
        node = container
    }
}
