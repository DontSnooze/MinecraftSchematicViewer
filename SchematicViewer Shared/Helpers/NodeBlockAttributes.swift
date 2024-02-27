//
//  BlockAttributes.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/27/24.
//

import SceneKit

struct NodeBlockAttributes {
    enum BlockType: String {
        case stairs
        case slab
        case hopper
        case sign
        case wallSign
        case block
        case glassPane
        case wood
        case water
        case chest
        case grassBlock
        case fence
        case lantern
        case chain
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
    
    enum SlabType: String {
        case bottom
        case top
        case double
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
    
    var name = ""
    var rawAttributesString = ""
    var blockType: BlockType = .block
    
    var axis: Axis = .none
    var facing: Direction = .none
    var attachment: Attachment = .none
    var slabType: SlabType = .none
    var halfType: HalfType = .none
    
    var north = false
    var south = false
    var east = false
    var west = false
    
    var powered = false
    var waterlogged = false
    var snowy = false
    var isHanging = false
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
        case "facing":
            guard let direction = Direction(rawValue: attributeValueString) else {
                return
            }
            facing = direction
        case "attachment":
            guard let attachmentObject = Attachment(rawValue: attributeValueString) else {
                return
            }
            attachment = attachmentObject
        case "type":
            guard let slabTypeObject = SlabType(rawValue: attributeValueString) else {
                return
            }
            slabType = slabTypeObject
        case "half":
            guard let halfTypeObject = HalfType(rawValue: attributeValueString) else {
                return
            }
            halfType = halfTypeObject
        case "north":
            north = attributeValueString.boolValue
            if north {
                directions.append(.north)
            }
        case "south":
            south = attributeValueString.boolValue
            if south {
                directions.append(.south)
            }
        case "east":
            east = attributeValueString.boolValue
            if east {
                directions.append(.east)
            }
        case "west":
            west = attributeValueString.boolValue
            if west {
                directions.append(.west)
            }
        case "powered":
            powered = attributeValueString.boolValue
        case "waterlogged":
            waterlogged = attributeValueString.boolValue
        case "snowy":
            snowy = attributeValueString.boolValue
        case "hanging":
            isHanging = attributeValueString.boolValue
        case "rotation":
            guard let rotationInt = Int(attributeValueString) else {
                return
            }
            rotation = rotationInt
        case "level":
            guard let levelInt = Int(attributeValueString) else {
                return
            }
            level = levelInt
        default:
            return
        }
    }
}
