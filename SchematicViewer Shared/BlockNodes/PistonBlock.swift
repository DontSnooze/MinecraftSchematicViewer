//
//  PistonBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/12/24.
//

import SceneKit

class PistonBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        guard
            let bottomImage = UIImage(named: "piston_bottom"),
            let pistonInner = UIImage(named: "piston_inner"),
            let pistonSide = UIImage(named: "piston_side"),
            let pistonTop = UIImage(named: "piston_top"),
            let pistonTopSticky = UIImage(named: "piston_top_sticky")
        else {
            return
        }
        
        var sideImage = pistonSide
        var topImage = pistonTop
        
        if attributes.name == "sticky_piston" {
            topImage = pistonTopSticky
        }
        
        if attributes.isExtended {
            sideImage = bottomImage
            topImage = pistonInner
        }
        node = SCNNode.sixImageBlock(frontImage: bottomImage, rightImage: sideImage, backImage: topImage, leftImage: sideImage, topImage: sideImage, bottomImage: sideImage)
        
        node.name = attributes.name
        applyAttributes()
    }
    
    func applyAttributes() {
        node.applyDirectionAttribute(attributes: attributes)
    }
}
