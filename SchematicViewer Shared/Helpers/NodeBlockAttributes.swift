//
//  BlockAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

struct NodeBlockAttributes {
    enum BlockType: String {
        case block
        case button
        case chain
        case chest
        case fence
        case fenceGate
        case glassPane
        case grassBlock
        case hopper
        case lantern
        case lever
        case rail
        case redstone
        case sign
        case slab
        case stairs
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
    
    var isPowered = false
    var waterlogged = false
    var snowy = false
    var isHanging = false
    var isOpen = false
    var rotation = -1
    var level = -1
    var directions = [Direction]()
    
    init(with name: String, attributesString: String) {
        self.name = name
        guard !attributesString.isEmpty else {
            return
        }
        self.rawAttributesString = attributesString
        setupBlockNameAttributes(from: name)
        setupAttributes(from: attributesString)
        setupCustomBlockTypes(from: name)
    }
    
    mutating func setupBlockNameAttributes(from blockName: String) {
        if name.hasSuffix("_button") {
            blockType = .button
        }
        if name.hasSuffix("_stairs") {
            blockType = .stairs
        }
        if name.hasSuffix("_slab") {
            blockType = .slab
        }
        if name.hasSuffix("_sign") {
            blockType = .sign
        }
        if name.hasSuffix("_wall_sign") {
            blockType = .wallSign
        }
        if name.hasSuffix("_glass_pane") {
            blockType = .glassPane
        }
        if name.hasSuffix("_wood") {
            blockType = .wood
        }
        if name.hasSuffix("_fence") {
            blockType = .fence
        }
        if name.hasSuffix("_fence_gate") {
            blockType = .fenceGate
        }
        if name.hasSuffix("_rail") || name == "rail" {
            blockType = .rail
        }
    }
    
    mutating func setupCustomBlockTypes(from name: String) {
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
        if name == "lantern" || name == "soul_lantern"{
            blockType = .lantern
        }
        if name == "chain"{
            blockType = .chain
        }
        if name == "lever"{
            blockType = .lever
        }
        if name == "redstone_wire"{
            blockType = .redstone
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
