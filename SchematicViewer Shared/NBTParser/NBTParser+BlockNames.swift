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
        let blockDict = [Int: String]()
        /*
        let blockIdDictionary = NBTParser.nbtCompoundNodeValue(nbt: nbt, key: "BlockIDs")
        
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
        */
        return blockDict
    }
    
    static func blockDictionary(nbt: NBT) -> [Int: NodeBlock] {
        var blockDict = [Int: NodeBlock]()
        
        guard 
            let schematic = schematicFromNbt(nbt: nbt),
            let blockIdDictionary = paletteFromSchematic(schematic: schematic)
        else {
            print("Could not load palette from schematic")
            return blockDict
        }
        
        for (blockDescriptionValue, paletteIdTag) in blockIdDictionary {
            
            // block name and attributes
//            print("\n=======\n")
//            print("blockDescriptionValue: \(blockDescriptionValue)")
            
            // block id:  NBTInt
            guard let paletteIdNbtInt = paletteIdTag as? NBTInt else {
                continue
            }
            
            let paletteId = paletteIdNbtInt.value
            
            // remove "minecraft:"
            var blockName = ""
            
            if let name = blockDescriptionValue.slice(from: ":", to: "[") {
                blockName = name
            } else {
                blockName = blockDescriptionValue.slice(from: ":", to: "") ?? ""
            }
            
            let blockAttributes = blockDescriptionValue.slice(from: "[", to: "]") ?? ""
            
//            print("paletteId: \(paletteId)")
//            print("blockName: \(String(describing: blockName))")
//            print("blockAttributes: \(String(describing: blockAttributes))")
            
            let nodeBlock = NodeBlock(with: blockName, attributesString: blockAttributes, paletteId: Int(paletteId))
            
            blockDict[Int(paletteId)] = nodeBlock
        }
        
        return blockDict
    }
    
//    static func attributesFromString(_ string: String) -> [String: String] {
//        let attributes
//    }
}
