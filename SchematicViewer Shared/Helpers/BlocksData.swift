//
//  BlocksData.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/18/24.
//

import SceneKit

struct BlocksData {
    var mapLevels: [[SCNNode]]
    var hiddenLevels = [Int]()
    
    func blockCounts() -> [String: Int] {
        var detailsDict = [String: Int]()
        
        for level in 0..<mapLevels.count {
            guard !hiddenLevels.contains(level) else {
                continue
            }
            
            for block in mapLevels[level] {
                guard let blockName = block.name else {
                    continue
                }
                
                if let currentValue = detailsDict[blockName] {
                    detailsDict[blockName] = currentValue + 1
                } else {
                    detailsDict[blockName] = 1
                }
            }
        }
        
        return detailsDict
    }
}

extension BlocksData {
    static func dummyMapLevels() -> [[SCNNode]] {
        var levels = [[SCNNode]]()
        
        for i in 1...4 {
            var level = [SCNNode]()
            
            for _ in 0..<2 {
                let node = SCNNode()
                node.name = "Block \(i)"
                level.append(node)
            }
            
            levels.append(level)
        }
        
        return levels
    }
}
