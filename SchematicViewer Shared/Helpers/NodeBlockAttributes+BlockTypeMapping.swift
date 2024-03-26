//
//  NodeBlockAttributes+BlockTypeMapping.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 3/16/24.
//

import SceneKit

extension NodeBlockAttributes {
    mutating func setupBlockType(from name: String) {
        switch name {
        case "comparator":
            blockType = .comparator
        case "hopper":
            blockType = .hopper
        case "chest":
            blockType = .chest
        case "water":
            blockType = .water
        case "grass_block":
            blockType = .grassBlock
        case "lantern",
             "soul_lantern":
            blockType = .lantern
        case "chain":
            blockType = .chain
        case "lever":
            blockType = .lever
        case "redstone_wire":
            blockType = .redstone
        case "repeater":
            blockType = .repeater
        case "tall_grass":
            blockType = .tallGrass
        default:
            break
        }
    }
}
