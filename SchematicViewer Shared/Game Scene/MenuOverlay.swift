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
    func testButtonPressed()
}

class MenuOverlay: SKScene {
    var hudLabel: SKLabelNode?
    var blockCountsButton: SKSpriteNode?
    var mapLevelsButton: SKSpriteNode?
    var importFileButton: SKSpriteNode?
    var testButton: SKSpriteNode?
    var menuOverlayDelegate: MenuOverlayDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        setupHud()
        setupBlockCountsButton()
        setupMapLevelsButton()
        setupImportButton()
        setupTestButton()
    }
    
    func setupHud() {
        let label = SKLabelNode(fontNamed: "Helvetica")
        
        label.text = "Schematic"
        label.fontColor = UIColor.white
        label.fontSize = 16
        label.setScale(1.0)
        label.position = CGPoint(x: 0, y: -label.frame.size.height / 2)
        
        hudLabel = label
        
        let color = UIColor.black
        let alphaColor = color.withAlphaComponent(0.9)
        let labelBackground = SKSpriteNode(color: alphaColor, size: CGSize(width: label.frame.size.width * 5, height: label.frame.size.height + 8))
        
        labelBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        labelBackground.addChild(label)
        
        self.addChild(labelBackground)
    }
    
    func setupBlockCountsButton() {
        guard let image = UIImage(systemName: "chart.bar.doc.horizontal.fill") else {
            return
        }
        let texture = SKTexture(image: image)
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: size.width - 40, y: size.height - 40)
        button.setScale(1.0)
        button.name = "BlockCountsButton"
        
        self.addChild(button)
        blockCountsButton = button
    }
    
    func setupMapLevelsButton() {
        guard let image = UIImage(systemName: "list.bullet.clipboard.fill") else {
            return
        }
        let texture = SKTexture(image: image)
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: size.width - 80, y: size.height - 40)
        button.setScale(1.0)
        button.name = "MapLevelsButton"
        
        self.addChild(button)
        mapLevelsButton = button
    }
    
    func setupImportButton() {
        guard let image = UIImage(systemName: "arrow.down.doc.fill") else {
            return
        }
        let texture = SKTexture(image: image)
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: size.width - 120, y: size.height - 40)
        button.setScale(1.0)
        button.name = "ImportFileButton"
        self.addChild(button)
        importFileButton = button
    }
    
    func setupTestButton() {
        guard let image = UIImage(systemName: "questionmark.app.fill") else {
            return
        }
        let texture = SKTexture(image: image)
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: size.width - 160, y: size.height - 40)
        button.setScale(1.0)
        button.name = "TestButton"
        
        self.addChild(button)
        testButton = button
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        if 
            let button = blockCountsButton,
            button.contains(location)
        {
            menuOverlayDelegate?.blockCountsButtonPressed()
            return
        }
        
        if 
            let button = mapLevelsButton,
            button.contains(location)
        {
            menuOverlayDelegate?.mapLevelsButtonPressed()
            return
        }
        
        if 
            let button = importFileButton,
            button.contains(location) {
            menuOverlayDelegate?.importFileButtonPressed()
            return
        }
        
        if 
            let button = testButton,
            button.contains(location)
        {
            menuOverlayDelegate?.testButtonPressed()
            return
        }
        
        let updatedLocation = convertPoint(fromView: location)
        menuOverlayDelegate?.overlayTouchesEnded(location: updatedLocation)
    }
}
