//
//  NodeBlockAttributes+NameMapping.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/16/24.
//

import SceneKit

extension NodeBlockAttributes {
    mutating func setupBlockAttributes(from blockName: String) {
        if name.hasSuffix("_banner") {
            blockType = .banner
        }
        if name.hasSuffix("_button") {
            blockType = .button
        }
        if name.hasSuffix("_carpet") {
            blockType = .carpet
        }
        if name.hasSuffix("_door") {
            blockType = .door
        }
        if name.hasSuffix("_fence") {
            blockType = .fence
        }
        if name.hasSuffix("_fence_gate") {
            blockType = .fenceGate
        }
        if name.hasSuffix("_glass_pane") {
            blockType = .glassPane
        }
        if
            name.hasSuffix("_head"),
            name != "piston_head"
        {
            blockType = .head
        }
        if name.hasSuffix("piston") {
            blockType = .piston
        }
        if name.hasSuffix("piston_head") {
            blockType = .pistonHead
        }
        if name.hasSuffix("rail") {
            blockType = .rail
        }
        if name.hasSuffix("_sign") {
            blockType = .sign
        }
        if name.hasSuffix("_skull") {
            blockType = .head
        }
        if name.hasSuffix("_slab") {
            blockType = .slab
        }
        if name.hasSuffix("_stairs") {
            blockType = .stairs
        }
        if name.hasSuffix("torch") {
            blockType = .torch
        }
        if name.hasSuffix("_trapdoor") {
            blockType = .trapDoor
        }
        if name.hasSuffix("_wall") {
            blockType = .wall
        }
        if name.hasSuffix("_wall_sign") {
            blockType = .wallSign
        }
        if name.hasSuffix("_wood") {
            blockType = .wood
        }
    }
}
