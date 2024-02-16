//
//  NBTParser+BlockNames.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SwiftNBT

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
}
