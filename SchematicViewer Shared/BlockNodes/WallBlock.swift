//
//  WallBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/11/24.
//

import SceneKit

class WallBlock: SVNode {
    var attributes: NodeBlockAttributes
    var node = SCNNode()
    
    var blockImage: UIImage? {
        var imageName = attributes.name.replacingOccurrences(of: "_wall", with: "")
        
        if imageName.hasSuffix("_brick") {
            imageName += "s"
        }
        
        guard let image = UIImage(named: imageName) else {
            print("wall image was nil")
            return nil
        }
        
        return image
    }
    
    init(with attributes: NodeBlockAttributes) {
        self.attributes = attributes
        setup()
    }
    
    func applyAttributes() {
        node.name = attributes.name
        for childNode in node.childNodes {
            childNode.name = attributes.name
        }
    }
    
    func setup() {
        guard let scene = SCNScene(named: "Art.scnassets/wall.scn") else {
            print("wall scene is nil")
            return
        }
        
        let nodeName = attributes.directions.contains(.up) ? "wall_up" : "wall"
        
        guard
            let parentNode = scene.rootNode.childNode(withName: nodeName, recursively: true),
            let postNode = parentNode.childNode(withName: "up", recursively: true),
            let northNode = parentNode.childNode(withName: "north", recursively: true),
            let southNode = parentNode.childNode(withName: "south", recursively: true),
            let eastNode = parentNode.childNode(withName: "east", recursively: true),
            let westNode = parentNode.childNode(withName: "west", recursively: true)
        else {
            print("wall node is nil")
            return
        }
        
        setupAttributes()
        let resultNode = SCNNode()
        resultNode.addChildNode(postNode)
        
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
        
        let material = SCNMaterial()
        if let image = blockImage {
            material.diffuse.contents = image
        } else {
            print("blockImage was nil")
            material.diffuse.contents = UIColor.cyan
            material.transparency = 0.6
        }
        
        for childNode in resultNode.childNodes {
            childNode.geometry?.materials = [material]
        }
        
        node = resultNode
        applyAttributes()
    }
    
    func setupAttributes() {
        // separate by comma
        let attributeStrings = attributes.rawAttributesString.split(separator: ",")
        for attributeString in attributeStrings {
            // separate by "="
            let attributes = attributeString.split(separator: "=")
            
            let attribute = String(attributes[0])
            let attributeValue = String(attributes[1])
            
            mapAttribute(attributeString: attribute, attributeValueString: attributeValue)
        }
    }
    
    func mapAttribute(attributeString: String, attributeValueString: String) {
        guard attributeValueString != "none" else {
            return
        }
        
        switch attributeString {
        case "east":
            attributes.directions.append(.east)
        case "north":
            attributes.directions.append(.north)
        
        case "south":
            attributes.directions.append(.south)
        case "west":
            attributes.directions.append(.west)
        default:
            return
        }
    }
}
