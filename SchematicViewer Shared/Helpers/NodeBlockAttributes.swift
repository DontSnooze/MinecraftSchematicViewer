//
//  BlockAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

struct NodeBlockAttributes {
    enum BlockType: String {
        case anvil
        case bamboo
        case banner
        case bed
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
        case flowerPot
        case glassPane
        case grassBlock
        case grindstone
        case head
        case hopper
        case ladder
        case lantern
        case lectern
        case lever
        case pitcherPlant
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
        case vine
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
    
    enum Part: String {
        case head
        case foot
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
    var part: Part = .none
    
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
        || name.hasSuffix("bell")
        || name.hasSuffix("bluet")
        || name.hasSuffix("bud")
        || name.hasSuffix("bush")
        || name.hasSuffix("brewing_stand")
        || name.hasSuffix("campfire")
        || name.hasSuffix("cluster")
        || name.hasSuffix("coral")
        || name.hasSuffix("coral_fan")
        || name.hasSuffix("daisy")
        || name.hasSuffix("dripstone")
        || name.hasSuffix("end_rod")
        || name.hasSuffix("fern")
        || name.hasSuffix("fungus")
        || name.hasSuffix("grass")
        || name.hasSuffix("lightning_rod")
        || name.hasSuffix("lilac")
        || name.hasSuffix("mushroom")
        || name.hasSuffix("orchid")
        || name.hasSuffix("petals")
        || name.hasSuffix("peony")
        || name.hasSuffix("pitcher_plant")
        || name.hasSuffix("poppy")
        || name.hasSuffix("propagule")
        || name.hasSuffix("roots")
        || name.hasSuffix("sapling")
        || name.hasSuffix("sprouts")
        || name.hasSuffix("torch")
        || name.hasSuffix("torchflower")
        || name.hasSuffix("tulip")
        || name.hasSuffix("tripwire_hook")
        || name.hasSuffix("vines")
        || name.hasSuffix("wither_rose")
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
        || name.hasSuffix("tripwire")
        || name.hasSuffix("lily_pad")
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
