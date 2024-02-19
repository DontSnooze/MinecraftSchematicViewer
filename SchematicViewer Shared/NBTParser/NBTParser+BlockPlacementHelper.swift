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
        let position = blockPosition(from: nbt, index: index)
        var block = SceneBlock.createBlock()
        
        if let customBlock = customBlock(blockId: blockId) {
            block = customBlock
        } else {
            let blockNames = blockNameDictionary(nbt: nbt)
            let blockName = blockNames[blockId] ?? ""
            block = blockFromName(blockName: blockName)
        }
        
        block.position = position
        return block
    }
    
    static func blockPosition(from nbt: NBT, index: Int) -> SCNVector3 {
        var x = 0
        var y = 0
        var z = 0
        
        let mapLength = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Length"))
        let mapWidth = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Width"))
        let mapHeight = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Height"))
        
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
    
    static func blockFromName(blockName: String) -> SCNNode {
        var sideImage: UIImage?
        var topImage: UIImage?
        var bottomImage: UIImage?
        var frontImage: UIImage?
        var backImage: UIImage?

        // check for main image
        var fileName = blockName

        if let image = UIImage(named: fileName) {
            sideImage = image
            topImage = image
            bottomImage = image
            frontImage = image
            backImage = image
        }

        // check for side image
        fileName = blockName + "_side"

        if let image = UIImage(named: fileName) {
            sideImage = image
        }

        // check for top image
        fileName = blockName + "_top"
        
        if let image = UIImage(named: fileName) {
            topImage = image
        }

        // check for bottom image
        fileName = blockName + "_bottom"
        
        if let image = UIImage(named: fileName) {
            bottomImage = image
        }

        // check for front image
        fileName = blockName + "_front"

        if let image = UIImage(named: fileName) {
            frontImage = image
        }

        // check for back image
        fileName = blockName + "_back"
        
        if let image = UIImage(named: fileName) {
            backImage = image
        }

        let block = SceneBlock.sixImageBlock(frontImage: frontImage, rightImage: sideImage, backImage: backImage, leftImage: sideImage, topImage: topImage, bottomImage: bottomImage)
        
        block.name = blockName
        
        return block
    }
    
    static func stairsBlockFromName(blockName: String, halfType: NodeBlock.HalfType = .bottom) -> SCNNode {
        
        var sideImage: UIImage?
        var topImage: UIImage?
        var bottomImage: UIImage?
        var frontImage: UIImage?
        var backImage: UIImage?

        // check for main image
        var fileName = blockName.replacingOccurrences(of: "_stairs", with: "")

        if let image = UIImage(named: fileName) {
            sideImage = image
            topImage = image
            bottomImage = image
            frontImage = image
            backImage = image
        }

        // check for side image
        fileName = blockName + "_side"

        if let image = UIImage(named: fileName) {
            sideImage = image
        }

        // check for top image
        fileName = blockName + "_top"
        
        if let image = UIImage(named: fileName) {
            topImage = image
        }

        // check for bottom image
        fileName = blockName + "_bottom"
        
        if let image = UIImage(named: fileName) {
            bottomImage = image
        }

        // check for front image
        fileName = blockName + "_front"

        if let image = UIImage(named: fileName) {
            frontImage = image
        }

        // check for back image
        fileName = blockName + "_back"
        
        if let image = UIImage(named: fileName) {
            backImage = image
        }

        let block = SceneBlock.stairsBlock(frontImage: frontImage, rightImage: sideImage, backImage: backImage, leftImage: sideImage, topImage: topImage, bottomImage: bottomImage)
        
        block.name = blockName
        
        return block
    }
    
    static func addAllSchematicBlocks(nbt: NBT, scene: SCNScene, removinglevels: [Int] = []) -> [[SCNNode]] {
//        var blocks = new THREE.Object3D();
        let blockIndexArray = NBTParser.nbtByteArrayNodeValue(nbt: nbt, key: "Blocks")
        let mapLength = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Length"))
        let mapWidth = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Width"))
        
        var blockLevelsArray = [[SCNNode]]()
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
        return blockLevelsArray
    }
    
    static func addAllBlocks(nbt: NBT, scene: SCNScene, removinglevels: [Int] = []) -> [[SCNNode]] {

        let blockPaletteDictionary = blockDictionary(nbt: nbt)
        
        let blockIndexArray = NBTParser.nbtByteArrayNodeValue(nbt: nbt, key: "BlockData")
        let mapLength = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Length"))
        let mapWidth = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Width"))
        
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
            
            let position = blockPosition(from: nbt, index: i)
            block.position = position
            block.name = "[\(nodeBlock.paletteId)][\(nodeBlock.name)] \(nodeBlock.rawAttributesString)"
            
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

        return blockLevelsArray
    }
    
    static func customBlock(blockId: Int) -> SCNNode? {
        var block: SCNNode?
        
        switch blockId {
        // water
        case 9:
            block = SCNNode.waterBlock()
        
        // grass dirt
        case 2:
            block = SCNNode.grassBlock()
            
        // chest
        case 54:
            block = SCNNode.chestBlock()
        default:
            return block
            
        }
        
        return block
    }
    
    static func customBlock(blockName: String) -> SCNNode? {
        var block: SCNNode?
        
        switch blockName {
        // water
        case "water":
            block = SCNNode.waterBlock()
        
        // grass dirt
        case "grass_block":
            block = SCNNode.grassBlock()
            
        // chest
        case "chest":
            block = SCNNode.chestBlock()
        default:
            return block
            
        }
        
        return block
    }
}
