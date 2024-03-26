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
//            let fileName = "slabTest_low_to_up"
//            let fileName = "chest_s_e_n_w_dble"
//            let fileName = "futHouse9"
//            let fileName = "redstone_and_doors"
//            let fileName = "Boulevardier's_Japanese_Chateau"
//            let fileName = "chicken"
//            let fileName = "Modern_House_3"
//            let fileName = "MH1"
//            let fileName = "Model4"
            let fileName = "McDonalds2"
            
            let fileType = "schem"
//            let fileType = "schematic"
            
//            await loadBundleNBTWithPrompt(fileName: fileName)
            await loadBundleNBT(fileName: fileName, ofType: fileType)
        }

//        addBlock()
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
        let viewModel = BlocksMenuView.ViewModel(mapLevels: gameSceneController.mapLevels, hiddenLevels: gameSceneController.hiddenMapLevels, hiddenBlocks: gameSceneController.hiddenBlocks)
        viewModel.delegate = self
        let vc = UIHostingController(rootView: BlocksMenuView(viewModel: viewModel))
        vc.view.isOpaque = false
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func showMapLevelsMenu() {
        guard 
            let nbt = gameSceneController.parsedNbt,
            let schematic = NBTParser.schematicFromNbt(nbt: nbt),
            let height = NBTParser.heightFromSchematic(schematic: schematic)
        else {
            print("could not show showMapLevelsMenu. parsedNbt is nil.")
            return
        }
        
        let viewModel = MapLevelsMenuView.ViewModel(levelCount: height, hiddenLevels: gameSceneController.hiddenMapLevels)
        viewModel.delegate = self
        
        let vc = UIHostingController(rootView: MapLevelsMenuView(viewModel: viewModel))
        
        vc.view.isOpaque = false
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func showLoadingTreatment(_ show: Bool = true) {
        menuOverlay?.loadingImage?.isHidden = !show
        menuOverlay?.importFileButton?.isHidden = show
    }
    
    func loadBundleNBT(fileName: String = "hopper_s_e_n_w_dwn", ofType: String = "schem") async {
        let path = Bundle.main.path(forResource: fileName, ofType: ofType) ?? ""
        
        if FileManager.fileExists(filePath: path) {
            menuOverlay?.hudLabel?.text = "\(fileName) exists"
        } else {
            menuOverlay?.hudLabel?.text = "\(fileName) does not exist"
        }
        
        await parseSchem(path: path)
    }
    
    func loadBundleNBTWithPrompt(fileName: String = "hopper_s_e_n_w_dwn", ofType: String = "schem") async {
        let path = Bundle.main.path(forResource: fileName, ofType: ofType) ?? ""
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
    
    func addBlock() {
        let image = UIImage(named: "tall_grass_top")
        let block = SCNNode.spriteBlock(image: image, name: "tall_grass")
        gameView.scene?.rootNode.addChildNode(block)
    }
}

extension FileManager {
    class func fileExists(filePath: String) -> Bool {
        var isDirectory = ObjCBool(false)
        return self.default.fileExists(atPath: filePath, isDirectory: &isDirectory)
    }
}
