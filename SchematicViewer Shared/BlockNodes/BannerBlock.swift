//
//  BannerBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class BannerBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/banner.scn") else {
            print("banner scene is nil")
            return
        }
        
        let nodeName = attributes.name.hasSuffix("_wall_banner") ? "wall_banner" : "banner"
        
        guard
            let parentNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let bannerNode = parentNode.childNode(withName: "banner", recursively: true)
        else {
            print("banner node is nil")
            return
        }
        
        let material = SCNMaterial()
        if let color = bannerColor() {
            material.diffuse.contents = color
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        bannerNode.geometry?.materials = [material]
        bannerNode.name = attributes.name
        
        applyAttributes(node: parentNode)
        
        node = parentNode.flattenedClone()
        node.name = attributes.name
    }
    
    func applyAttributes(node: SCNNode?) {
        node?.applyDirectionAttribute(attributes: attributes)
    }
    
    func applyAttributes() {}
    
    func bannerColor() -> UIColor? {
        let colorString = attributes.name
            .replacingOccurrences(of: "_banner", with: "")
            .replacingOccurrences(of: "_wall", with: "")
        
        return UIColor.colorWith(name: colorString)
    }
}
