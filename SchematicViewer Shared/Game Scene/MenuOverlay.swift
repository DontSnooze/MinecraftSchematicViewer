//
//  MenuOverlay.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/18/24.
//

import SpriteKit
import SceneKit

protocol MenuOverlayDelegate: AnyObject {
    func blockCountsButtonPressed()
    func mapLevelsButtonPressed()
    func overlayTouchesEnded(location: CGPoint)
    func importFileButtonPressed()
}

class MenuOverlay: SKScene {
    var hudLabel: SKLabelNode!
    var blockCountsButton: SKSpriteNode!
    var mapLevelsButton: SKSpriteNode!
    var importFileButton: SKSpriteNode!
    var menuOverlayDelegate: MenuOverlayDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        hudLabel = SKLabelNode(fontNamed: "Helvetica")
        hudLabel.text = "Schematic"
        hudLabel.fontColor = UIColor.white
        hudLabel.fontSize = 16
        hudLabel.setScale(1.0)
        hudLabel.position = CGPoint(x: 0, y: -hudLabel.frame.size.height / 2)
        
        let color = UIColor.black
        let alphaColor = color.withAlphaComponent(0.9)
        let labelBackground = SKSpriteNode(color: alphaColor, size: CGSize(width: hudLabel.frame.size.width * 5, height: hudLabel.frame.size.height + 8))
        
        labelBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        
        labelBackground.addChild(hudLabel)
        
        blockCountsButton = SKSpriteNode(imageNamed: "BlockCountsMenuButton")
        blockCountsButton.position = CGPoint(x: size.width - 40, y: size.height - 40)
        blockCountsButton.setScale(0.2)
        blockCountsButton.name = "BlockCountsButton"
        
        mapLevelsButton = SKSpriteNode(imageNamed: "BlockCountsMenuButton")
        mapLevelsButton.position = CGPoint(x: size.width - 80, y: size.height - 40)
        mapLevelsButton.setScale(0.2)
        mapLevelsButton.name = "MapLevelsButton"
        
        importFileButton = SKSpriteNode(imageNamed: "BlockCountsMenuButton")
        importFileButton.position = CGPoint(x: size.width - 120, y: size.height - 40)
        importFileButton.setScale(0.2)
        importFileButton.name = "ImportFileButton"
        
        super.init(size: size)
        
        self.addChild(blockCountsButton)
        self.addChild(mapLevelsButton)
        self.addChild(importFileButton)
        self.addChild(labelBackground)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        if blockCountsButton.contains(location) {
            menuOverlayDelegate?.blockCountsButtonPressed()
            return
        }
        
        if mapLevelsButton.contains(location) {
            menuOverlayDelegate?.mapLevelsButtonPressed()
            return
        }
        
        if importFileButton.contains(location) {
            menuOverlayDelegate?.importFileButtonPressed()
            return
        }
        
        let updatedLocation = convertPoint(fromView: location)
        menuOverlayDelegate?.overlayTouchesEnded(location: updatedLocation)
    }
}
