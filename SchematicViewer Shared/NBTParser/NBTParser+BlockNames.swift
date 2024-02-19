//
//  NBTParser+BlockNames.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SwiftNBT
import SceneKit

extension NBTParser {
    static func blockNameDictionary(nbt: NBT) -> [Int: String] {
        var blockDict = [Int: String]()
        let blockIdDictionary = NBTParser.nbtCompundNodeValue(nbt: nbt, key: "BlockIDs")
        
        for (blockId, nbtTag) in blockIdDictionary {
            guard let nbtString = nbtTag as? NBTString else {
                continue
            }
            
            var nbtName = nbtString.value
            nbtName.removeFirst(10)
            
            if let id = Int(blockId) {
                blockDict[id] = nbtName
            }
        }
        
        return blockDict
    }
    
    static func blockDictionary(nbt: NBT) -> [Int: NodeBlock] {
        var blockDict = [Int: NodeBlock]()
        let blockIdDictionary = NBTParser.nbtCompundNodeValue(nbt: nbt, key: "Palette")
        
        for (blockDescriptionValue, paletteIdTag) in blockIdDictionary {
            
            // block name and attributes
            print("\n=======\n")
//            print("blockDescriptionValue: \(blockDescriptionValue)")
            
            // block id:  NBTInt
            guard let paletteIdNbtInt = paletteIdTag as? NBTInt else {
                continue
            }
            
            var paletteId = paletteIdNbtInt.value
            
            // remove "minecraft:"
            var blockName = ""
            
            if let name = blockDescriptionValue.slice(from: ":", to: "[") {
                blockName = name
            } else {
                blockName = blockDescriptionValue.slice(from: ":", to: "") ?? ""
            }
            
            var blockAttributes = blockDescriptionValue.slice(from: "[", to: "]") ?? ""
            
            print("paletteId: \(paletteId)")
            print("blockName: \(String(describing: blockName))")
            print("blockAttributes: \(String(describing: blockAttributes))")
            
            let nodeBlock = NodeBlock(with: blockName, attributesString: blockAttributes, paletteId: Int(paletteId))
            print("nodeBlock: \(nodeBlock)")
            
            blockDict[Int(paletteId)] = nodeBlock
            
//            if let id = Int(blockId) {
//                blockDict[id] = nbtName
//            }
        }
        
        return blockDict
    }
    
//    static func attributesFromString(_ string: String) -> [String: String] {
//        let attributes
//    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        guard let fromRange = from.isEmpty ? startIndex..<startIndex : range(of: from) else { return nil }
        guard let toRange = to.isEmpty ? endIndex..<endIndex : range(of: to, range: fromRange.upperBound..<endIndex) else { return nil }
        
        return String(self[fromRange.upperBound..<toRange.lowerBound])
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
