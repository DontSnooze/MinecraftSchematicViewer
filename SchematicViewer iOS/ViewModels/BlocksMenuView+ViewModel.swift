//
//  BlocksMenu+ViewModel.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation
import SceneKit

protocol BlocksMenuViewDelegate: AnyObject {
    func hiddenBlocksUpdated(hiddenBlocks: [String])
}

extension BlocksMenuView {
    class ViewModel: ObservableObject {
        var delegate: BlocksMenuViewDelegate?
        var mapLevels: [[SCNNode]]
        var hiddenLevels: [Int]
        
        @Published var searchText = ""
        @Published var hiddenBlocks = [String]()
        
        init(mapLevels: [[SCNNode]], hiddenLevels: [Int], hiddenBlocks: [String]) {
            self.mapLevels = mapLevels
            self.hiddenLevels = hiddenLevels
            self.hiddenBlocks = hiddenBlocks
        }
        
        var blockCounts: [String: Int] {
            BlocksData(mapLevels: mapLevels, hiddenLevels: hiddenLevels).blockCounts()
        }
        
        var filteredBlockCounts: [String: Int] {
            if searchText.isEmpty {
                return blockCounts
            } else {
                return blockCounts.filter {
                    let blockName = $0.key
                    return blockName.lowercased().contains(searchText.lowercased())
                }
            }
        }
        
        func blockIsHidden(block: String) -> Bool {
            return hiddenBlocks.contains(block)
        }
        
        func imageForBlockVisibility(block: String) -> String {
            blockIsHidden(block: block) ? "eye.slash" : "eye"
        }
        
        func showAllBlocks() {
            hiddenBlocks.removeAll()
            delegate?.hiddenBlocksUpdated(hiddenBlocks: hiddenBlocks)
        }
        
        func hideAllBlocks() {
            blockCounts.forEach { (key: String, _) in
                hiddenBlocks.append(key)
            }
            delegate?.hiddenBlocksUpdated(hiddenBlocks: hiddenBlocks)
        }
        
        func handleVisibilityPressed(block: String) {
            if blockIsHidden(block: block) {
                hiddenBlocks.removeAll { hiddenBlock in
                    hiddenBlock == block
                }
            } else {
                hiddenBlocks.append(block)
            }
            delegate?.hiddenBlocksUpdated(hiddenBlocks: hiddenBlocks)
        }
    }
}
