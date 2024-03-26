//
//  SlabBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

class SlabBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var image: UIImage?
        let fileName = attributes.name.replacingOccurrences(of: "_slab", with: "")
        
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
        switch attributes.name {
        case "smooth_stone_slab":
            node = smoothStoneSlabBlock()
        default:
            node = slabBlockNode(image: blockImage)
        }
        
        applyAttributes()
    }
    
    func slabBlockNode(image: UIImage?) -> SCNNode {
        return SCNNode.repeatedImageBlock(image: image)
    }
    
    func smoothStoneSlabBlock() -> SCNNode {
        var sideImage = UIImage(named: "smooth_stone_slab_side")
        let topImage = UIImage(named: "smooth_stone")
        
        if 
            attributes.slabType != .double,
            let image = sideImage
        {
            sideImage = splitImage(image2D: image)
        }
        
        let blockNode = SCNNode.sixImageBlock(frontImage: sideImage, rightImage: sideImage, backImage: sideImage, leftImage: sideImage, topImage: topImage, bottomImage: topImage)
        
        return blockNode
    }
    
    func applyAttributes() {
        node.name = attributes.name
        
        if attributes.slabType == .double {
            node.name = "double_\(attributes.name)"
        }
        
        switch attributes.slabType {
        case .bottom:
            applyBottomSlabAttributes()
        case .top:
            applyTopSlabAttributes()
        case .double:
            applyDoubleSlabAttributes()
        case .none:
            break
        }
    }
    
    func applyBottomSlabAttributes() {
        let pivot = SCNMatrix4MakeTranslation(0, 0.5, 0)
        node.pivot = pivot
        node.scale = SCNVector3(x: 1, y: 0.5, z: 1)
    }
    
    func applyTopSlabAttributes() {
        let pivot = SCNMatrix4MakeTranslation(0, -0.5, 0)
        node.pivot = pivot
        node.scale = SCNVector3(x: 1, y: 0.5, z: 1)
    }
    
    func applyDoubleSlabAttributes() {
    }
    
    func splitImage(image2D: UIImage) -> UIImage? {
        var image: UIImage?
        let imgHeight = image2D.size.height / 2
        let topHalf = CGRect(x: 0, y: 0, width: image2D.size.width, height: imgHeight)
        
        if let cropped = image2D.cgImage?.cropping(to: topHalf) {
            image = UIImage(cgImage: cropped)
        }
        
        return image
    }
}
