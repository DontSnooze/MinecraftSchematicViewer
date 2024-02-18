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
}

class MenuOverlay: SKScene {
    var myLabel: SKLabelNode!
    var blockCountsButton: SKSpriteNode!
    var mapLevelsButton: SKSpriteNode!
    var menuOverlayDelegate: MenuOverlayDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        myLabel = SKLabelNode(fontNamed: "Chalkduster")
        myLabel.text = "Schematic"
        myLabel.fontColor = UIColor.white
        myLabel.fontSize = 12
        myLabel.setScale(1.0)
        myLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        
        blockCountsButton = SKSpriteNode(imageNamed: "BlockCountsMenuButton")
        blockCountsButton.position = CGPoint(x: size.width - 40, y: size.height - 40)
        blockCountsButton.setScale(0.2)
        blockCountsButton.name = "BlockCountsButton"
        
        mapLevelsButton = SKSpriteNode(imageNamed: "BlockCountsMenuButton")
        mapLevelsButton.position = CGPoint(x: size.width - 80, y: size.height - 40)
        mapLevelsButton.setScale(0.2)
        mapLevelsButton.name = "MapLevelsButton"
        
        super.init(size: size)
        
        self.addChild(blockCountsButton)
        self.addChild(mapLevelsButton)
        self.addChild(myLabel)
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
        
        let updatedLocation = convertPoint(fromView: location)
        menuOverlayDelegate?.overlayTouchesEnded(location: updatedLocation)
    }
}
