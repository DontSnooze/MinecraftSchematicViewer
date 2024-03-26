//
//  NBTParser+BlockPlacementHelper.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/16/24.
//

import SwiftNBT
import SceneKit

extension NBTParser {
    static func removeAllNodes(from nodeGrid: [[SCNNode]]) {
        for level in nodeGrid {
            for node in level {
                node.removeFromParentNode()
            }
        }
    }
    
    static func blockForIndex(nbt: NBT, index: Int, blockId: Int) -> SCNNode {
        let block = SCNNode.createBlock()
        /*
        let position = blockPosition(from: nbt, index: index)
        
        if let customBlock = SCNNode.customBlock(blockId: blockId) {
            block = customBlock
        } else {
            let blockNames = blockNameDictionary(nbt: nbt)
            let blockName = blockNames[blockId] ?? ""
            block = SCNNode.blockFromName(blockName: blockName)
        }
        
        block.position = position
         */
        return block
    }
    
    static func blockPosition(index: Int, mapLength: Int, mapWidth: Int, mapHeight: Int) -> SCNVector3 {
        var x = 0
        var y = 0
        var z = 0
        
        // get y
        let mapPlaneCount = mapWidth * mapLength
        var currentPlaneCount = mapPlaneCount
        
        for i in 0..<mapHeight {
            if index < currentPlaneCount {
                y = i
                break
            } else {
                currentPlaneCount += mapPlaneCount
            }
        }
        
        // get z
        let mapPlaneLengthCount = mapLength
        var currentLengthCount = (y * mapPlaneCount) + mapWidth
        
        for i in 0..<mapPlaneLengthCount {
            if index < currentLengthCount {
                z = i
                break
            } else {
                currentLengthCount += mapWidth
            }
        }
        
        // get x
        let mapPlaneWidthCount = mapWidth
        let currentWidthCount = (y * mapPlaneCount) + (z * mapPlaneWidthCount)
        
        x = index - currentWidthCount
//        print("x: \(x), y: \(y), z: \(z),")
        
        return SCNVector3(x, y, z)
    }
    
    static func addAllSchematicBlocks(nbt: NBT, scene: SCNScene, removinglevels: [Int] = []) -> [[SCNNode]] {
        
//        var blocks = new THREE.Object3D();
//        let blockIndexArray = NBTParser.nbtByteArrayNodeValue(nbt: nbt, key: "Blocks")
//        let mapLength = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Length"))
//        let mapWidth = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Width"))
        
        let blockLevelsArray = [[SCNNode]]()
        /*
        var blockLevelArray = [SCNNode]()
        
        let levelArea = mapLength * mapWidth
        
        var currentPlaneCount = levelArea
        var currentLevel = 0
        
        for i in 0..<blockIndexArray.count {
            let blockId = blockIndexArray[i]
            
            // skip "air" blocks
            guard blockId != 0 else {
                if i == currentPlaneCount - 1 {
                    blockLevelsArray.append(blockLevelArray)
                    blockLevelArray = [SCNNode]()
                    currentPlaneCount += levelArea
                    currentLevel += 1
                }
                continue
            }
            
            let block = blockForIndex(nbt: nbt, index: i, blockId: Int(blockId))
            
            if !removinglevels.contains(currentLevel) {
                scene.rootNode.addChildNode(block)
                blockLevelArray.append(block)
            }
            
            if i == currentPlaneCount - 1 {
                blockLevelsArray.append(blockLevelArray)
                blockLevelArray = [SCNNode]()
                currentPlaneCount += levelArea
                currentLevel += 1
            }
        }
//        scene.add( blocks );
         */
        return blockLevelsArray
    }
    
    static func addAllBlocks(nbt: NBT, scene: SCNScene) -> [[SCNNode]] {
        let blockPaletteDictionary = blockDictionary(nbt: nbt)
        
        guard
            let schematic = schematicFromNbt(nbt: nbt),
            let mapLength = lengthFromSchematic(schematic: schematic),
            let mapWidth = widthFromSchematic(schematic: schematic),
            let mapHeight = heightFromSchematic(schematic: schematic)
        else {
            return []
        }
        
        let blockIndexArray = blockDataFromSchematic(schematic: schematic)
        
        var blockLevelsArray = [[SCNNode]]()
        var blockLevelArray = [SCNNode]()
        
        let levelArea = mapLength * mapWidth
        
        var currentPlaneCount = levelArea
        var currentLevel = 0
        
        for i in 0..<blockIndexArray.count {
            let paletteId = blockIndexArray[i]
            
            // skip "air" blocks
            guard 
                let nodeBlock = blockPaletteDictionary[Int(paletteId)],
                nodeBlock.name != "air"
            else {
                if i == currentPlaneCount - 1 {
                    blockLevelsArray.append(blockLevelArray)
                    blockLevelArray = [SCNNode]()
                    currentPlaneCount += levelArea
                    currentLevel += 1
                }
                continue
            }
            
            guard let block = nodeBlock.scnNode() else {
                continue
            }
            
            let position = blockPosition(index: i, mapLength: mapLength, mapWidth: mapWidth, mapHeight: mapHeight)
            block.position = position

            if isForDebug {
                block.name = "[\(nodeBlock.paletteId)][\(nodeBlock.name)] \(nodeBlock.attributes.rawAttributesString)"
            }
            
            scene.rootNode.addChildNode(block)
            blockLevelArray.append(block)
            
            if i == currentPlaneCount - 1 {
                blockLevelsArray.append(blockLevelArray)
                blockLevelArray = [SCNNode]()
                currentPlaneCount += levelArea
                currentLevel += 1
            }
        }
        return blockLevelsArray
    }
}
