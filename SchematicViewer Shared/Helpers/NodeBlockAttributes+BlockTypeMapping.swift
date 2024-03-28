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
        case "anvil":
            blockType = .anvil
        case "bamboo":
            blockType = .bamboo
        case "chain":
            blockType = .chain
        case "chest":
            blockType = .chest
        case "comparator":
            blockType = .comparator
        case "decorated_pot":
            blockType = .decoratedPot
        case "flower_pot":
            blockType = .flowerPot
        case "grass_block":
            blockType = .grassBlock
        case "grindstone":
            blockType = .grindstone
        case "hopper":
            blockType = .hopper
        case "lantern",
             "soul_lantern":
            blockType = .lantern
        case "lectern":
            blockType = .lectern
        case "lever":
            blockType = .lever
        case "redstone_wire":
            blockType = .redstone
        case "repeater":
            blockType = .repeater
        case "tall_grass":
            blockType = .tallGrass
        case "water":
            blockType = .water
        default:
            break
        }
    }
}
