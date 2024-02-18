//
//  MapLevelsMenu+ViewModel.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import Foundation

protocol MapLevelsMenuViewDelegate: AnyObject {
    func hiddenMapLevelsUpdated(hiddenLevels: [Int])
}

extension MapLevelsMenuView {
    class ViewModel: ObservableObject {
        var delegate: MapLevelsMenuViewDelegate?
        
        var levelCount: Int
        @Published var hiddenLevels: [Int]
        
        init(levelCount: Int, hiddenLevels: [Int] = [Int]()) {
            self.levelCount = levelCount
            self.hiddenLevels = hiddenLevels
        }
        
        func levelIsHidden(level: Int) -> Bool {
            return hiddenLevels.contains(level)
        }
        
        func textForLevelHideButton(level: Int) -> String {
            return levelIsHidden(level: level) ? "Show" : "Hide"
        }
        
        func showAllLevels() {
            hiddenLevels.removeAll()
        }
        
        func hideAllLevels() {
            hiddenLevels = Array(0..<levelCount)
        }
        
        func handleDonePressed() {
            delegate?.hiddenMapLevelsUpdated(hiddenLevels: hiddenLevels)
        }
    }
}
