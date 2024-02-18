//
//  SceneBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/12/24.
//

import Foundation
import SceneKit

class SceneBlock {
    static func createBlock() -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.05)
        let brick = SCNNode(geometry: g)
        
        brick.name = "brick"
        brick.geometry?.firstMaterial?.transparency = 0.6
        
        let brickColor = UIColor.cyan
        brick.geometry?.firstMaterial?.diffuse.contents = brickColor
        
        return brick
    }
    
    static func repeatedImageBlock(image: UIImage) -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.01)
        let block = SCNNode(geometry: g)
        
        block.name = "block"
        
        let  material = SCNMaterial()
        material.diffuse.contents = image
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
        if let frontImage = frontImage {
            let material = SCNMaterial()
            material.diffuse.contents = frontImage
            materials.append(material)
        }
        
        if let rightImage = rightImage {
            let material = SCNMaterial()
            material.diffuse.contents = rightImage
            materials.append(material)
        }
        
        if let backImage = backImage {
            let material = SCNMaterial()
            material.diffuse.contents = backImage
            materials.append(material)
        }
        
        if let leftImage = leftImage {
            let material = SCNMaterial()
            material.diffuse.contents = leftImage
            materials.append(material)
        }
        
        if let topImage = topImage {
            let material = SCNMaterial()
            material.diffuse.contents = topImage
            materials.append(material)
        }
        
        if let bottomImage = bottomImage {
            let material = SCNMaterial()
            material.diffuse.contents = bottomImage
            materials.append(material)
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
}
