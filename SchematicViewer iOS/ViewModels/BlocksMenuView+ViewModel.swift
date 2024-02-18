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
        
        init(mapLevels: [[SCNNode]]) {
            self.mapLevels = mapLevels
        }
        
        func blockCounts() -> [String: Int] {
            return BlocksData(mapLevels: mapLevels).blockCounts()
            
        }
    }
}
