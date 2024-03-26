//
//  SceneBlocksHelper.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/12/24.
//

import SceneKit

extension SCNNode {
    static func createBlock() -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.05)
        let brick = SCNNode(geometry: g)
        
        brick.name = "brick"
        brick.geometry?.firstMaterial?.transparency = 0.6
        
        let brickColor = UIColor.cyan
        brick.geometry?.firstMaterial?.diffuse.contents = brickColor
        
        return brick
    }
    
    static func repeatedImageBlock(image: UIImage?) -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.01)
        let block = SCNNode(geometry: g)
        
        block.name = "block"
        
        let material = SCNMaterial()
        
        if let image = image {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        block.geometry?.materials = [material]
        
        return block
    }
    
    static func sixImageBlock(imageNames: [String]) -> SCNNode {
        var materials = [SCNMaterial]()
        
        for name in imageNames {
            if let image = UIImage(named: name) {
                let  material = SCNMaterial()
                material.diffuse.contents = image
                materials.append(material)
            }
        }
        
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.01)
        let block = SCNNode(geometry: g)
        
        block.name = "block"
        block.geometry?.materials = materials
        
        return block
    }
    
    static func sixImageBlock(frontImage: UIImage?, 
                              rightImage: UIImage?,
                              backImage: UIImage?,
                              leftImage: UIImage?,
                              topImage: UIImage?,
                              bottomImage: UIImage?) -> SCNNode {
        
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.01)
        let block = SCNNode(geometry: g)
        
        var materials = [SCNMaterial]()
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        let images = [frontImage, rightImage, backImage, leftImage, topImage, bottomImage]
        
        for image in images {
            if let image = image {
                let material = SCNMaterial()
                material.diffuse.contents = image
                materials.append(material)
            }
        }
        
        // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
        if materials.isEmpty {
            block.geometry?.firstMaterial?.diffuse.contents = UIColor.cyan
            block.geometry?.firstMaterial?.transparency = 0.6
        } else {
            block.geometry?.materials = materials
        }
        return block
    }
    
    // [ PZ(FRONT) , PX(RIGHT) , NZ(BACK) , NX(LEFT) , PY(TOP) , NY(BOTTOM) ]
    static func sixImageBlock(pxImage: UIImage, nxImage: UIImage, pyImage: UIImage, nyImage: UIImage, pzImage: UIImage, nzImage: UIImage) -> SCNNode {
        return sixImageBlock(frontImage: pzImage, rightImage: pxImage, backImage: nzImage, leftImage: nxImage, topImage: pyImage, bottomImage: nyImage)
    }
    
    static func spriteBlock(image: UIImage?, name: String) -> SCNNode {
        let parentNode = SCNNode()
        let g = SCNPlane(width: 1, height: 1)
        let node1 = SCNNode(geometry: g)
        let node2 = SCNNode(geometry: g)
        
        let radial = GLKMathDegreesToRadians(45)
        
        node1.eulerAngles = SCNVector3Make(0, radial, 0)
        node2.eulerAngles = SCNVector3Make(0, -radial, 0)
        
        var materials = [SCNMaterial]()
        let material = SCNMaterial()
        
        if let image = image {
            material.diffuse.contents = image
            material.isDoubleSided = true
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        materials.append(material)
        node1.geometry?.materials = materials
        node2.geometry?.materials = materials
        
        node1.name = name
        node2.name = name
        
        parentNode.addChildNode(node1)
        parentNode.addChildNode(node2)
        
        return parentNode
    }
}
