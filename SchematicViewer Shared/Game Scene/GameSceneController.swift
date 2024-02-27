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
    var scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    var cameraNode: SCNNode
    var playerNode: SCNNode
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
        
//        let blockNode = NodeBlock(with: "oak_leaves", attributesString: "", paletteId: -1)
//        guard let block = blockNode.scnNode() else {
//            print("could not create node.")
//            return
//        }
//        scene.rootNode.addChildNode(block)
        
        NBTParser.parseNbt { nbt in
            self.parsedNbt = nbt
            self.handleParsedNbt(nbt: nbt)
        }
    }
    
    func parseNbt(path: String) {
        NBTParser.removeAllNodes(from: mapLevels)
        
        NBTParser.parseNbt(path: path) { nbt in
            self.parsedNbt = nbt
            self.handleParsedNbt(nbt: nbt)
        }
    }

    func highlightNodes(atPoint point: CGPoint) {
        let hitResults = self.sceneRenderer.hitTest(point, options: [:])
        for result in hitResults {
            // get its material
            let material = result.node.geometry?.firstMaterial
//            guard let materials = result.node.geometry?.materials else { return }
            
//            for material in materials {
                // highlight it
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                // on completion - unhighlight
                SCNTransaction.completionBlock = {
                    SCNTransaction.begin()
                    SCNTransaction.animationDuration = 0.5
                    
                    material?.emission.contents = SCNColor.black
                    
                    SCNTransaction.commit()
                }
                
                material?.emission.contents = SCNColor.red
                
                SCNTransaction.commit()
//            }
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
    
    func startSceneLoadTest() async {
        // create scene adding all blocks
        guard let (newScene, _) = await createScene() else {
            print("(newScene, levels) is nil")
            return
        }
        
        //  save scene
        saveScene(scene: newScene)
        
        // load
        loadScene()
    }
    
    func createScene() async -> (SCNScene, [[SCNNode]])? {
        guard let newScene = SCNScene(named: "Art.scnassets/world.scn") else {
            print("scene is nil")
            return nil
        }
        
        guard let newNbt = await NBTParser.parseTestNbtFile() else {
            print("could not parseTestNbt")
            return nil
        }
        
        let levels = NBTParser.addAllBlocks(nbt: newNbt, scene: newScene, removinglevels: [])
        
        return (newScene, levels)
    }
    
    func saveScene(scene: SCNScene) {
        let sceneToSave = scene
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentsPath.appendingPathComponent( "test.scn")
        sceneToSave.write(to: url, options: nil, delegate: nil, progressHandler: nil)
    }
    
    func loadScene() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentsPath.appendingPathComponent( "test.scn")
        
//        do {
//            try SCNScene(url: url, options: nil) 
//        } catch {
//            print(error.localizedDescription)
//        }
        
        guard let testScene = try? SCNScene(url: url, options: nil) else {
            return
        }
        
        guard let sceneCameraNode = testScene.rootNode.childNode(withName: "camera", recursively: true) else {
            fatalError("camera node is nil")
        }
        
        guard let scenePlayerNode = testScene.rootNode.childNode(withName: "player", recursively: true) else {
            fatalError("player node is nil")
        }
        
        playerNode = scenePlayerNode
        cameraNode = sceneCameraNode
        sceneRenderer.scene = testScene
        scene = testScene
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }

}
