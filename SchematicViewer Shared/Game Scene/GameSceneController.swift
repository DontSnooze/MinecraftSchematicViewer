//
//  GameSceneController.swift
//  SchematicViewer Shared
//
//  Created by Amos Todman on 2/8/24.
//

import SceneKit
import SwiftNBT

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameSceneController: NSObject, SCNSceneRendererDelegate {
    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    let cameraNode: SCNNode
    let playerNode: SCNNode
    var parsedNbt: NBT?
    var mapLevels = [[SCNNode]]()
    var hiddenMapLevels = [Int]()
    var blockPalette = [Int: SCNNode]()
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        
        guard let worldScene = SCNScene(named: "Art.scnassets/world.scn") else {
            fatalError("scene is nil")
        }
        
        scene = worldScene
        
        guard let sceneCamera = scene.rootNode.childNode(withName: "camera", recursively: true) else {
            fatalError("camera node is nil")
        }
        
        guard let node = scene.rootNode.childNode(withName: "player", recursively: true) else {
            fatalError("player node is nil")
        }
        
        cameraNode = sceneCamera
        playerNode = node
        super.init()
        
        sceneRenderer.delegate = self
        
//        if let ship = scene.rootNode.childNode(withName: "ship", recursively: true) {
//            ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
//        }
        
        sceneRenderer.scene = scene
        
//        let block = NBTParser.blockFromName(blockName: "stripped_oak_log")
//        scene.rootNode.addChildNode(block)
        
        NBTParser.parseNbt { nbt in
            self.parsedNbt = nbt
            self.handleParsedNbt(nbt: nbt)
        }
    }
    
    func addGrassBlock() {
        
        guard
            let sideImage = UIImage(named: "grass_side.png"),
            let topImage = UIImage(named: "grass_top.png"),
            let bottomImage = UIImage(named: "dirt.png")
        else {
            return
        }
        
        let block = SCNNode.sixImageBlock(frontImage: sideImage, rightImage: sideImage, backImage: sideImage, leftImage: sideImage, topImage: topImage, bottomImage: bottomImage)
        
        block.position = SCNVector3(0, 1, 0)
        
        scene.rootNode.addChildNode(block)
    }
    
    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = self.sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            // get its material
            guard let material = result.node.geometry?.firstMaterial else {
                return
            }
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = SCNColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = SCNColor.red
            
            SCNTransaction.commit()
        }
    }
    
    func handleParsedSchematicNbt(nbt: NBT) {
        mapLevels = NBTParser.addAllSchematicBlocks(nbt: nbt, scene: scene, removinglevels: [])
    }
    
    func handleParsedNbt(nbt: NBT) {
        mapLevels = NBTParser.addAllBlocks(nbt: nbt, scene: scene, removinglevels: [])
    }
    
    func updateMap(removinglevels: [Int]) {
        guard let nbt = parsedNbt else {
            print("Could not updateMap. parsedNbt is nil")
            return
        }
        
        NBTParser.removeAllNodes(from: mapLevels)
        hiddenMapLevels = removinglevels
        mapLevels = NBTParser.addAllBlocks(nbt: nbt, scene: scene, removinglevels: removinglevels)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }

}
