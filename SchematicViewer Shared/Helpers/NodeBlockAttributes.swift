//
//  BlockAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

struct NodeBlockAttributes {
    enum BlockType: String {
        case banner
        case block
        case button
        case carpet
        case chain
        case chest
        case comparator
        case door
        case fence
        case fenceGate
        case glassPane
        case grassBlock
        case head
        case hopper
        case lantern
        case lever
        case piston
        case pistonHead
        case rail
        case redstone
        case repeater
        case sign
        case slab
        case stairs
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
    
    init(with name: String, attributesString: String) {
        self.name = name
        setupBlockNameAttributes(from: name)
        setupCustomBlockTypes(from: name)
        
        guard !attributesString.isEmpty else {
            return
        }
        self.rawAttributesString = attributesString
        
        setupAttributes(from: attributesString)
    }
    
    mutating func setupBlockNameAttributes(from blockName: String) {
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
        if name.hasSuffix("_rail") || name == "rail" {
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
    
    mutating func setupAttributes(from string: String) {
        // separate by comma
        let attributeStrings = string.split(separator: ",")
        for attributeString in attributeStrings {
            // separate by "="
            let attributes = attributeString.split(separator: "=")
            
            let attribute = String(attributes[0])
            let attributeValue = String(attributes[1])
            
            mapAttribute(attributeString: attribute, attributeValueString: attributeValue)
        }
    }
    
    mutating func mapAttribute(attributeString: String, attributeValueString: String) {
        switch attributeString {
        case "axis":
            guard let axisObject = Axis(rawValue: attributeValueString) else {
                return
            }
            axis = axisObject
        case "attachment":
            guard let attachmentObject = Attachment(rawValue: attributeValueString) else {
                return
            }
            attachment = attachmentObject
        case "east":
            east = attributeValueString.boolValue
            if east {
                directions.append(.east)
            }
        case "face":
            guard let faceObject = Face(rawValue: attributeValueString) else {
                return
            }
            face = faceObject
        case "facing":
            guard let direction = Direction(rawValue: attributeValueString) else {
                return
            }
            facing = direction
        case "half":
            guard let halfTypeObject = HalfType(rawValue: attributeValueString) else {
                return
            }
            halfType = halfTypeObject
        case "hanging":
            isHanging = attributeValueString.boolValue
        case "extended":
            isExtended = attributeValueString.boolValue
        case "level":
            guard let levelInt = Int(attributeValueString) else {
                return
            }
            level = levelInt
        case "north":
            north = attributeValueString.boolValue
            if north {
                directions.append(.north)
            }
        case "open":
            isOpen = attributeValueString.boolValue
        case "powered":
            isPowered = attributeValueString.boolValue
        case "rotation":
            guard let rotationInt = Int(attributeValueString) else {
                return
            }
            rotation = rotationInt
        case "shape":
            guard let shapeObject = Shape(rawValue: attributeValueString) else {
                return
            }
            shape = shapeObject
        case "snowy":
            snowy = attributeValueString.boolValue
        case "south":
            south = attributeValueString.boolValue
            if south {
                directions.append(.south)
            }
        case "type":
            guard let slabTypeObject = SlabType(rawValue: attributeValueString) else {
                return
            }
            slabType = slabTypeObject
        case "up":
            up = attributeValueString.boolValue
            if up {
                directions.append(.up)
            }
        case "waterlogged":
            waterlogged = attributeValueString.boolValue
        case "west":
            west = attributeValueString.boolValue
            if west {
                directions.append(.west)
            }
        default:
            return
        }
    }
}
