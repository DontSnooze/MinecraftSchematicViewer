//
//  GameViewController+MenuOverlayDelegate.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation

extension GameViewController: MenuOverlayDelegate {
    func blockCountsButtonPressed() {
        showBlockCountsMenu()
    }
    
    func mapLevelsButtonPressed() {
        showMapLevelsMenu()
    }
    
    func importFileButtonPressed() {
        showDocumentPicker()
    }
    
    func testButtonPressed() {
        Task {
            await gameSceneController.startSceneLoadTest()
        }
    }
    
    func overlayTouchesEnded(location: CGPoint) {
        let hitResults = gameView.hitTest(location, options: nil)
        
        for result in hitResults {
//            display node name
//            print("node name: \(String(describing: result.node.name))")
            gameSceneController.highlightNodes(atPoint: location)
            menuOverlay?.hudLabel.text = result.node.name ?? ""
        }
    }
}
