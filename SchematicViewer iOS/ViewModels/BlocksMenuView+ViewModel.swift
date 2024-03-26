//
//  BlocksMenu+ViewModel.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation
import SceneKit

extension BlocksMenuView {
    struct ViewModel {
        var mapLevels: [[SCNNode]]
        var hiddenLevels: [Int]
        
        func blockCounts() -> [String: Int] {
            return BlocksData(mapLevels: mapLevels, hiddenLevels: hiddenLevels).blockCounts()
            
        }
    }
}
