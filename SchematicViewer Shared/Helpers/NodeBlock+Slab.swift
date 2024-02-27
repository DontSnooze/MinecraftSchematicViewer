//
//  NodeBlock+Slab.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/19/24.
//
import SceneKit

extension NodeBlock {
    func applySlabAttributes(to block: SCNNode) {
        switch attributes.slabType {
        case .bottom:
            applyBottomSlabAttributes(to: block)
        case .top:
            applyTopSlabAttributes(to: block)
        case .double:
            applyDoubleSlabAttributes(to: block)
        case .none:
            break
        }
    }
    
    func applyBottomSlabAttributes(to block: SCNNode) {
        let pivot = SCNMatrix4MakeTranslation(0, 0.5, 0)
        block.pivot = pivot
        block.scale = SCNVector3(x: 1, y: 0.5, z: 1)
    }
    
    func applyTopSlabAttributes(to block: SCNNode) {
        let pivot = SCNMatrix4MakeTranslation(0, -0.5, 0)
        block.pivot = pivot
        block.scale = SCNVector3(x: 1, y: 0.5, z: 1)
    }
    
    func applyDoubleSlabAttributes(to block: SCNNode) {
        
    }
}
