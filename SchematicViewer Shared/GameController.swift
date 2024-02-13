//
//  GameController.swift
//  SchematicViewer Shared
//
//  Created by Amos Todman on 2/8/24.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        
        guard let worldScene = SCNScene(named: "Art.scnassets/world.scn") else {
            print("scene is nil")
            fatalError("scene is nil")
        }
        
        scene = worldScene
        
        super.init()
        
        sceneRenderer.delegate = self
        
//        if let ship = scene.rootNode.childNode(withName: "ship", recursively: true) {
//            ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
//        }
        
        sceneRenderer.scene = scene
        
        let block = SceneBlock.createBlock()
        block.position = SCNVector3(0, 0, 0)
        
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
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // Called before each frame is rendered
    }

}
