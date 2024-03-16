//
//  NodeBlockAttributes+CustomBlockAttributes.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 3/16/24.
//

import SceneKit

extension NodeBlockAttributes {
    mutating func setupCustomBlockTypes(from name: String) {
        if name == "comparator" {
            blockType = .comparator
        }
        if name == "hopper" {
            blockType = .hopper
        }
        if name == "chest" {
            blockType = .chest
        }
        if name == "water" {
            blockType = .water
        }
        if name == "grass_block" {
            blockType = .grassBlock
        }
        if name == "lantern" || name == "soul_lantern" {
            blockType = .lantern
        }
        if name == "chain" {
            blockType = .chain
        }
        if name == "lever" {
            blockType = .lever
        }
        if name == "redstone_wire" {
            blockType = .redstone
        }
        if name == "repeater" {
            blockType = .repeater
        }
    }
}
