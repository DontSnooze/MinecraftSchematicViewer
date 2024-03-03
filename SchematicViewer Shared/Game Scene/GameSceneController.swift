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
        sceneRenderer.scene = scene
        
//        let block = NBTParser.blockFromName(blockName: "stripped_oak_log")
//        scene.rootNode.addChildNode(block)
        
//        let blockNode = NodeBlock(with: "oak_leaves", attributesString: "", paletteId: -1)
//        guard let block = blockNode.scnNode() else {
//            print("could not create node.")
//            return
//        }
//        scene.rootNode.addChildNode(block)
    }
    
    func parseNbt(path: String) async {
        NBTParser.removeAllNodes(from: mapLevels)
        
        let nbt = await NBTParser.parseNbt(path: path)
        await loadScene(with: nbt)
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
        mapLevels = NBTParser.addAllBlocks(nbt: nbt, scene: scene)
    }
    
    func updateMap(removinglevels: [Int]) {
        let ignoredNodes = ["playerNode", "camera"]
        for node in scene.rootNode.childNodes {
            guard !ignoredNodes.contains(node.name ?? "") else {
                continue
            }
            
            let y = node.position.y
            let shouldHide = removinglevels.contains(Int(y))
            node.isHidden = shouldHide
        }
        
        hiddenMapLevels = removinglevels
    }
    
    func loadScene(with nbt: NBT) async {
        // create scene adding all blocks
        guard let (newScene, levels) = await createScene(with: nbt) else {
            print("(newScene, levels) is nil")
            return
        }
        
        //  save scene to tmp dir
        saveSceneToTempDirectory(scene: newScene)
        
        // load scene from tmp dir
        loadSceneFromTempDirectory()
        parsedNbt = nbt
        mapLevels = levels
    }
    
    func createScene(with nbt: NBT) async -> (SCNScene, [[SCNNode]])? {
        guard let newScene = SCNScene(named: "Art.scnassets/world.scn") else {
            print("scene is nil")
            return nil
        }
        
        let levels = NBTParser.addAllBlocks(nbt: nbt, scene: newScene)
        
        return (newScene, levels)
    }
    
    func saveSceneToTempDirectory(scene: SCNScene) {
//        guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Could not create documents path")
//            return
//        }
//        
//        let url = documentsPath.appendingPathComponent( "temp.scn")
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("temp.scn")
        scene.write(to: url, options: nil, delegate: nil, progressHandler: nil)
    }
    
    func loadSceneFromTempDirectory() {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("temp.scn")
//        guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Could not create documents path")
//            return
//        }
//        let url = documentsPath.appendingPathComponent( "temp.scn")
        
//        do {
//            try SCNScene(url: url, options: nil) 
//        } catch {
//            print(error.localizedDescription)
//        }
        
        guard let newScene = try? SCNScene(url: url, options: nil) else {
            return
        }
        
        guard let sceneCameraNode = newScene.rootNode.childNode(withName: "camera", recursively: true) else {
            fatalError("camera node is nil")
        }
        
        guard let scenePlayerNode = newScene.rootNode.childNode(withName: "player", recursively: true) else {
            fatalError("player node is nil")
        }
        
        playerNode = scenePlayerNode
        cameraNode = sceneCameraNode
        sceneRenderer.scene = newScene
        scene = newScene
        hiddenMapLevels = []
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }

}
