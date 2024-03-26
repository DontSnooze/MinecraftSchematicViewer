//
//  GameViewController+BlocksMenuViewDelegate.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 3/26/24.
//

extension GameViewController: BlocksMenuViewDelegate {
    func hiddenBlocksUpdated(hiddenBlocks: [String]) {
        
        guard hiddenBlocks != gameSceneController.hiddenBlocks else {
            return
        }
        gameSceneController.updateMap(removingBlocks: hiddenBlocks)
    }
}
