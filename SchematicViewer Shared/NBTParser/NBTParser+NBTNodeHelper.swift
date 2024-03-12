//
//  NBTParser+NBTNodeHelper.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//
import SwiftNBT

extension NBTParser {
    static func nbtRoot(nbt: NBT) -> [String: any NBTTag] {
        guard let root = nbt.rootTag as? NBTCompound else {
            print("Could not get root from nbt")
            return [:]
        }
        
        return root.value
    }
    
    static func testCompound(nbt: NBT) {
        // find schematic files
        guard let schematic = schematicFromNbt(nbt: nbt) else {
            print("Could not read schematic")
            return
        }
        
        // find block data
        let blockData = blockDataFromSchematic(schematic: schematic)
        
        // find palette
        guard let palette = paletteFromSchematic(schematic: schematic) else {
            print("Could not load palette from schematic")
            return
        }
        
        // find length
        guard let length = lengthFromSchematic(schematic: schematic) else {
            print("Could not load length from schematic")
            return
        }
        
        // find width
        guard let width = widthFromSchematic(schematic: schematic) else {
            print("Could not load width from schematic")
            return
        }
        
        // find height
        guard let height = heightFromSchematic(schematic: schematic) else {
            print("Could not load height from schematic")
            return
        }
    }
    
    static func schematicFromNbt(nbt: NBT) -> [String: NBTTag]? {
        let root = nbt.rootTag as? NBTCompound
        
        var schematic: [String: NBTTag]?
        
        // fabric style
        // fabric style schematic keys: ["Offset", "Length", "Height", "Blocks", "Metadata", "Width", "DataVersion", "Version"]
        if let schematicObject = root?.value["Schematic"] as? NBTCompound {
            schematic = schematicObject.value
        } else if
            let schematicObject = root?.value as? [String: NBTTag],
            schematicObject.keys.contains("Palette"),
            schematicObject.keys.contains("Length"),
            schematicObject.keys.contains("Width"),
            schematicObject.keys.contains("Height")
        {
            // forge? style
            // ["BlockEntities", "Height", "PaletteMax", "Version", "Width", "Palette", "Offset", "Length", "Metadata", "BlockData", "DataVersion"]
            schematic = schematicObject
        }
        
        return schematic
    }
    
    static func lengthFromSchematic(schematic: [String: NBTTag]) -> Int? {
        let object = schematic["Length"] as? NBTShort
        guard let length = object?.value else {
            return nil
        }
        
        return Int(length)
    }
    
    static func widthFromSchematic(schematic: [String: NBTTag]) -> Int? {
        let object = schematic["Width"] as? NBTShort
        guard let width = object?.value else {
            return nil
        }
        
        return Int(width)
    }
    
    static func heightFromSchematic(schematic: [String: NBTTag]) -> Int? {
        let object = schematic["Height"] as? NBTShort
        guard let height = object?.value else {
            return nil
        }
        
        return Int(height)
    }
    
    static func paletteFromSchematic(schematic: [String: NBTTag]) -> [String: NBTTag]? {
        var palette: NBTCompound?
        
        if
            let blocks = schematic["Blocks"] as? NBTCompound,
            let paletteObject = blocks.value["Palette"] as? NBTCompound
        {
            palette = paletteObject
        } else if let paletteObject = schematic["Palette"] as? NBTCompound {
            palette = paletteObject
        }
        
        return palette?.value
    }
    
    static func blockDataFromSchematic(schematic: [String: NBTTag]) -> [Int8] {
        var blockData: NBTByteArray?
        
        if
            let blocks = schematic["Blocks"] as? NBTCompound,
            let data = blocks.value["Data"] as? NBTByteArray
        {
            // blocks keys: ["Data", "Palette", "BlockEntities"]
            blockData = data
        } else if let blocks = schematic["BlockData"] as? NBTByteArray {
            blockData = blocks
        }
        
        guard let results = blockData?.value else {
            return []
        }
        
        return results
    }
    /*
    static func nbtByteNodeValue(nbt: NBT, key: String) -> Int8 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTByte else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtByteArrayNodeValue(nbt: NBT, key: String) -> [Int8] {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTByteArray else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtCompoundNodeValue(nbt: NBT, key: String) -> [String: NBTTag] {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTCompound else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtDoubleNodeValue(nbt: NBT, key: String) -> Float64 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTDouble else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtFloatNodeValue(nbt: NBT, key: String) -> Float32 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTFloat else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtIntNodeValue(nbt: NBT, key: String) -> Int32 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTInt else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtIntArrayNodeValue(nbt: NBT, key: String) -> [Int32] {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTIntArray else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtListNodeValue(nbt: NBT, key: String) -> [NBTTag] {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTList else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtLongNodeValue(nbt: NBT, key: String) -> Int64 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTLong else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtLongArrayNodeValue(nbt: NBT, key: String) -> [Int64] {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTLongArray else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtShortNodeValue(nbt: NBT, key: String) -> Int16 {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTShort else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
    
    static func nbtStringNodeValue(nbt: NBT, key: String) -> String {
        let root = nbtRoot(nbt: nbt)
        
        guard
            let nodeValue = root[key],
            let targetNode = nodeValue as? NBTString else {
            fatalError("could not create targetNode from node value")
        }
        
        return targetNode.value
    }
     */
}
