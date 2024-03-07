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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSceneController = GameSceneController(sceneRenderer: gameView)
        gameSceneController.delegate = self
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
        
        // open an initial schematic
        Task {
//            let fileName = "hopper_s_e_n_w_dwn"
//            let fileName = "stairs_n_w_s_e_upsdwn"
//            let fileName = "sign_s_e_n_w_stand"
//            let fileName = "chest_s_e_n_w_dble"
            let fileName = "futHouse9"
//            let fileName = "redstone_and_doors"
//            await loadBundleNBT(fileName: fileName)
            await loadBundleNBTWithPrompt(fileName: fileName)
        }
    }
    
    func setupVirtualController() {
        virtualController.setup()
        gameSceneController.virtualController = virtualController.virtualController
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
    
    func showLoadingTreatment(_ show: Bool = true) {
        menuOverlay?.loadingImage?.isHidden = !show
        menuOverlay?.importFileButton?.isHidden = show
    }
    
    func loadBundleNBT(fileName: String = "hopper_s_e_n_w_dwn") async {
        let path = Bundle.main.path(forResource: fileName, ofType: "schem") ?? ""
        await parseSchem(path: path)
    }
    
    func loadBundleNBTWithPrompt(fileName: String = "hopper_s_e_n_w_dwn") async {
        let path = Bundle.main.path(forResource: fileName, ofType: "schem") ?? ""
        await handleDocumentPicked(path: path)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
