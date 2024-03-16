//
//  GlassPane.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/26/24.
//

import SceneKit

class GlassPaneBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    var blockImage: UIImage? {
        var image: UIImage?
        
        // check for main image
        let fileName = attributes.name.replacingOccurrences(of: "_pane", with: "")
        if let fileImage = UIImage(named: fileName) {
            image = fileImage
        }
        return image
    }
    
    init(attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func setup() {
        // check for full length panes
        let westSet = Set([NodeBlockAttributes.Direction.east, NodeBlockAttributes.Direction.west])
        let northSet = Set([NodeBlockAttributes.Direction.north, NodeBlockAttributes.Direction.south])
        let directionSet = Set(attributes.directions.sorted())
        
        switch directionSet {
        case northSet:
            setupFullGlassPaneBlockNode(facing: .west)
        case westSet:
            setupFullGlassPaneBlockNode(facing: .north)
        default:
            setupGlasppPaneNode()
        }
    }
    
    func setupGlasppPaneNode() {
        guard let scene = SCNScene(named: "Art.scnassets/glass_pane.scn") else {
            print("glass pane scene is nil")
            return
        }
        
        let blockNodeName = "glass_pane_block"
        
        guard
            let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true),
            let centerNode = blockNode.childNode(withName: "center", recursively: true),
            let northNode = blockNode.childNode(withName: "north", recursively: true),
            let southNode = blockNode.childNode(withName: "south", recursively: true),
            let eastNode = blockNode.childNode(withName: "east", recursively: true),
            let westNode = blockNode.childNode(withName: "west", recursively: true)
        else {
            print("glass pane node is nil")
            return
        }
        
        let resultNode = SCNNode()
        
        if attributes.directions.isEmpty || attributes.directions.contains(.none) {
            resultNode.addChildNode(centerNode)
        }
        for direction in attributes.directions {
            switch direction {
            case .north:
                resultNode.addChildNode(northNode)
            case .south:
                resultNode.addChildNode(southNode)
            case .east:
                resultNode.addChildNode(eastNode)
            case .west:
                resultNode.addChildNode(westNode)
            default:
                break
            }
        }
        
        node = resultNode.flattenedClone()
        node.name = attributes.name
        
        let material = SCNMaterial()
        
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        node.geometry?.materials = [material]
    }
    
    func setupFullGlassPaneBlockNode(facing: NodeBlockAttributes.Direction) {
        guard let scene = SCNScene(named: "Art.scnassets/glass_pane.scn") else {
            print("glass pane scene is nil")
            return
        }

        let blockNodeName = facing == .north ? "full_glass_pane_north" : "full_glass_pane_west"
        
        guard let blockNode = scene.rootNode.childNode(withName: blockNodeName, recursively: true) else {
            print("glass pane node is nil")
            return
        }
        
        let material = SCNMaterial()
        
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        blockNode.geometry?.materials = [material]
        
        node = blockNode
    }
    
    func applyAttributes() {}
}
