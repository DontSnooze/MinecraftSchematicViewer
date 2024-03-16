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
        
        print("blockData: \(blockData)")
        print("palette: \(palette)")
        print("length: \(length)")
        print("width: \(width)")
        print("height: \(height)")
    }
    
    static func schematicFromNbt(nbt: NBT) -> [String: NBTTag]? {
        let root = nbt.rootTag as? NBTCompound
        
        var schematic: [String: NBTTag]?
        
        if let schematicObject = root?.value["Schematic"] as? NBTCompound {
            // fabric style
            // fabric style schematic keys: ["Offset", "Length", "Height", "Blocks", "Metadata", "Width", "DataVersion", "Version"]
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
}
