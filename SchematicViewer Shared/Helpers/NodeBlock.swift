//
//  NodeBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation
import SceneKit

struct NodeBlock {
    enum BlockType: String {
        case stairs
        case slab
        case hopper
        case sign
        case block
    }
    
    enum Direction: String {
        case up,
        down,
        north,
        south,
        east,
        west,
        none
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
    
    var rawAttributesString = ""
    var blockType: BlockType = .block
    var facing: Direction = .none
    var attachment: Attachment = .none
    var slabType: SlabType = .none
    var halfType: HalfType = .none
    
    var name = ""
    var paletteId = -1
    
    var north = false
    var south = false
    var east = false
    var west = false
    
    var powered = false
    var waterlogged = false
    var snowy = false
    var rotation = -1
    var level = -1
    
    init(with name: String, attributesString: String, paletteId: Int) {
        self.name = name
        self.paletteId = paletteId
        self.rawAttributesString = attributesString
        
        setupBlockNameAttributes(from: name)
        setupAttributes(from: attributesString)
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
        if name == "hopper" {
            blockType = .hopper
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
        case "south":
            south = attributeValueString.boolValue
        case "east":
            east = attributeValueString.boolValue
        case "west":
            west = attributeValueString.boolValue
            
        case "powered":
            powered = attributeValueString.boolValue
        case "waterlogged":
            waterlogged = attributeValueString.boolValue
        case "snowy":
            snowy = attributeValueString.boolValue
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
    
    func scnNode() -> SCNNode? {
        var block: SCNNode?
        
        if let customBlock = NBTParser.customBlock(blockName: name) {
            block = customBlock
        } else if blockType == .stairs {
            block = NBTParser.stairsBlockFromName(blockName: name, halfType: halfType)
        } else {
            block = NBTParser.blockFromName(blockName: name)
        }
        
        if let block = block {
            applyAttributes(to: block)
        }
        
        return block
    }
    
    func applyAttributes(to block: SCNNode) {
        switch blockType {
        case .stairs:
            applyStairsAttributes(to: block)
        case .slab:
            applySlabAttributes(to: block)
        case .hopper:
            break
        case .sign:
            break
        case .block:
            break
        }
    }
    
    func applyDirectionAttribute(to block: SCNNode) {
        switch facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
    
    func rotateNode() {
        
    }
}
