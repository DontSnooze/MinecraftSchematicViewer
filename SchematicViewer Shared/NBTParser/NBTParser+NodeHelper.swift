//
//  NBTParser+NodeHelper.swift
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
    
    static func nbtCompundNodeValue(nbt: NBT, key: String) -> [String: NBTTag] {
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
}
