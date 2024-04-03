//
//  PitcherPlantBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 4/3/24.
//

import SceneKit

class PitcherPlantBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        let imageName = attributes.halfType == .upper ? "pitcher_crop_top_stage_4" : "pitcher_plant_bottom"
        return UIImage(named: imageName)
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        node = SCNNode.spriteBlock(image: blockImage, name: attributes.name)
        applyAttributes()
    }
    
    func applyAttributes() {
        node.name = attributes.name
    }
}
