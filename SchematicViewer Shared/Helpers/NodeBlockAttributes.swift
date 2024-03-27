//
//  BlockAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

struct NodeBlockAttributes {
    enum BlockType: String {
        case bamboo
        case banner
        case block
        case button
        case carpet
        case chain
        case chest
        case comparator
        case decoratedPot
        case door
        case fence
        case fenceGate
        case glassPane
        case grassBlock
        case head
        case hopper
        case ladder
        case lantern
        case lever
        case piston
        case pistonHead
        case pressurePlate
        case rail
        case redstone
        case repeater
        case sign
        case slab
        case stairs
        case tallGrass
        case torch
        case trapDoor
        case wall
        case wallSign
        case water
        case wood
    }
    
    enum Direction: String, Comparable {
        static func < (lhs: NodeBlockAttributes.Direction, rhs: NodeBlockAttributes.Direction) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        case up
        case down
        case north
        case south
        case east
        case west
        case none
    }
    
    enum Face: String {
        case floor
        case wall
        case ceiling
        case none
    }
    
    enum SlabType: String {
        case bottom
        case double
        case top
        case none
    }
    
    enum HalfType: String {
        case bottom
        case top
        case lower
        case upper
        case none
    }
    
    enum Attachment: String {
        case floor
        case none
    }
    
    enum Axis: String {
        case x
        case y
        case z
        case none
    }
    
    enum Shape: String {
        case north_west
        case north_east
        case south_west
        case south_east
        case north_south
        case east_west
        case none
    }
    
    var name = ""
    var rawAttributesString = ""
    var blockType: BlockType = .block
    
    var axis: Axis = .none
    var face: Face = .none
    var facing: Direction = .none
    var attachment: Attachment = .none
    var slabType: SlabType = .none
    var halfType: HalfType = .none
    var shape: Shape = .none
    
    var north = false
    var south = false
    var east = false
    var west = false
    var up = false
    
    var isPowered = false
    var waterlogged = false
    var snowy = false
    var isExtended = true
    var isHanging = false
    var isOpen = false
    var rotation = -1
    var level = -1
    var directions = [Direction]()
    var age = -1
    
    var isSprite: Bool {
        name.hasSuffix("allium")
        || name.hasSuffix("bluet")
        || name.hasSuffix("bud")
        || name.hasSuffix("bush")
        || name.hasSuffix("brewing_stand")
        || name.hasSuffix("campfire")
        || name.hasSuffix("cluster")
        || name.hasSuffix("daisy")
        || name.hasSuffix("dripstone")
        || name.hasSuffix("fern")
        || name.hasSuffix("fungus")
        || name.hasSuffix("grass")
        || name.hasSuffix("mushroom")
        || name.hasSuffix("orchid")
        || name.hasSuffix("poppy")
        || name.hasSuffix("propagule")
        || name.hasSuffix("roots")
        || name.hasSuffix("sapling")
        || name.hasSuffix("sprouts")
        || name.hasSuffix("tulip")
        || name.hasSuffix("tripwire_hook")
        || name.hasSuffix("vines")
    }
    
    var isHalfHeightBlock: Bool {
        name.hasSuffix("sculk_sensor")
        || name.hasSuffix("stonecutter")
    }
    
    var isThirdHeightBlock: Bool {
        name.hasSuffix("daylight_detector")
    }
    
    var isHalfSizedBlock: Bool {
        name.hasSuffix("conduit")
    }
    
    var isFlatPlaneBlock: Bool {
        name.hasSuffix("glow_lichen")
    }
    
    init(with name: String, attributesString: String) {
        self.name = name
        setupBlockAttributes(from: name)
        setupBlockType(from: name)
        
        guard !attributesString.isEmpty else {
            return
        }
        self.rawAttributesString = attributesString
        
        setupAttributes(from: attributesString)
    }
}
