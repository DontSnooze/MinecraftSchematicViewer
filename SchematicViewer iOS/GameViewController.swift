//
//  GameViewController.swift
//  SchematicViewer iOS
//
//  Created by Amos Todman on 2/8/24.
//

import UIKit
import SceneKit
import GameController
import SpriteKit

class GameViewController: UIViewController {

    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameSceneController: GameSceneController!
    var virtualController = VirtualController()
    
    var leftThumbstickHorizontalTimer: Timer?
    var leftThumbstickVerticalTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameSceneController = GameSceneController(sceneRenderer: gameView)
        // Allow the user to manipulate the camera
//        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = UIColor.black
        
        // Add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        var gestureRecognizers = gameView.gestureRecognizers ?? []
        gestureRecognizers.insert(tapGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
        
        // setup virtual comntroller
        setupVirtualController()
    }
    
    @objc
    func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        // Highlight the tapped nodes
        let p = gestureRecognizer.location(in: gameView)
        gameSceneController.highlightNodes(atPoint: p)
    }
    
    func setupVirtualController() {
        virtualController.delegate = self
        virtualController.setup()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
