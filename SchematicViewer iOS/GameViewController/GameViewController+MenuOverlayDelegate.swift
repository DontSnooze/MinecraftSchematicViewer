//
//  GameViewController+MenuOverlayDelegate.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import UIKit

extension GameViewController: MenuOverlayDelegate {
    func blockCountsButtonPressed() {
        showBlockCountsMenu()
    }
    
    func mapLevelsButtonPressed() {
        showMapLevelsMenu()
    }
    
    func importFileButtonPressed() {
        guard
            let isHidden = menuOverlay?.loadingImage?.isHidden,
            isHidden
        else {
            return
        }
        
        showDocumentPicker()
    }
    
    func resetPositionButtonPressed() {
        resetPosition()
    }
    
    func overlayTouchesEnded(location: CGPoint) {
        let hitResults = gameView.hitTest(location, options: nil)
        
        for result in hitResults {
//            display node name
//            print("node name: \(String(describing: result.node.name))")
            gameSceneController.highlightNodes(atPoint: location)
            menuOverlay?.hudLabel?.text = result.node.name ?? ""
        }
    }
    
    func showOkAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
}
