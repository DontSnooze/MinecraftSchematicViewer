//
//  NodeBlockAttributes+AttributeMapping.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 3/16/24.
//

import SceneKit

extension NodeBlockAttributes {
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
        case "age":
            guard let ageValue = Int(attributeValueString) else {
                return
            }
            age = ageValue
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
