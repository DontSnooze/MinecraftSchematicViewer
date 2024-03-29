//
//  GameViewController+MapLevelsMenuDelegate.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

extension GameViewController: MapLevelsMenuViewDelegate {
    func hiddenMapLevelsUpdated(hiddenLevels: [Int]) {
        guard hiddenLevels != gameSceneController.hiddenMapLevels else {
            return
        }
        gameSceneController.updateMap(removinglevels: hiddenLevels)
        gameSceneController.updateMap(removingBlocks: gameSceneController.hiddenBlocks)
    }
    
    func donePressed(hiddenLevels: [Int]) {
        
    }
}
