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
import SwiftUI

class GameViewController: UIViewController {

    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameSceneController: GameSceneController!
    var virtualController = VirtualController()
    var menuOverlay: MenuOverlay?
    
    var leftThumbstickHorizontalTimer: Timer?
    var leftThumbstickVerticalTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSceneController = GameSceneController(sceneRenderer: gameView)
        // Allow the user to manipulate the camera
//        gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        gameView.showsStatistics = true
        
        // Configure the view
        gameView.backgroundColor = UIColor.black
        
        // setup virtual comntroller
        setupVirtualController()
        
        // setup menu
        setupMenuOverlay()
    }
    
    func setupVirtualController() {
        virtualController.delegate = self
        virtualController.setup()
    }
    
    func setupMenuOverlay() {
        menuOverlay = MenuOverlay(size: view.bounds.size)
        menuOverlay?.menuOverlayDelegate = self
        
        gameView.overlaySKScene = menuOverlay
    }
    
    func showBlockCountsMenu() {
        let viewModel = BlocksMenuView.ViewModel(mapLevels: gameSceneController.mapLevels)
        let vc = UIHostingController(rootView: BlocksMenuView(viewModel: viewModel))
        present(vc, animated: true)
    }
    
    func showMapLevelsMenu() {
        guard let nbt = gameSceneController.parsedNbt else {
            print("could not show showMapLevelsMenu. parsedNbt is nil.")
            return
        }
        
        let height = Int(NBTParser.nbtShortNodeValue(nbt: nbt, key: "Height"))
        let viewModel = MapLevelsMenuView.ViewModel(levelCount: height, hiddenLevels: gameSceneController.hiddenMapLevels)
        viewModel.delegate = self
        
        let vc = UIHostingController(rootView: MapLevelsMenuView(viewModel: viewModel))
        present(vc, animated: true)
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
