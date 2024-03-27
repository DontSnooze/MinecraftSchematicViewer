//
//  NodeBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/18/24.
//

import SceneKit

struct NodeBlock {
    var name = ""
    var attributes: NodeBlockAttributes
    var paletteId = -1
    
    init(with name: String, attributesString: String, paletteId: Int) {
        self.name = name
        self.paletteId = paletteId
        attributes = NodeBlockAttributes(with: name, attributesString: attributesString)
    }
    
    func scnNode() -> SCNNode? {
        var block: SCNNode?
        switch attributes.blockType {
        case .banner:
            block = BannerBlock(with: attributes).node
        case .block:
            block = GenericBlock(with: attributes).node
        case .button:
            block = ButtonBlock(with: attributes).node
        case .carpet:
            block = CarpetBlock(with: attributes).node
        case .chain:
            block = ChainBlock(with: attributes).node
        case .chest:
            block = ChestBlock(with: attributes).node
        case .comparator:
            block = ComparatorBlock(with: attributes).node
        case .door:
            block = DoorBlock(with: attributes).node
        case .fence:
            block = FenceBlock(with: attributes).node
        case .fenceGate:
            block = FenceGateBlock(with: attributes).node
        case .glassPane:
            block = GlassPaneBlock(attributes: attributes).node
        case .grassBlock:
            block = GrassBlock(with: attributes).node
        case .head:
            block = HeadBlock(with: attributes).node
        case .hopper:
            block = HopperBlock(with: attributes).node
        case .lantern:
            block = LanternBlock(with: attributes).node
        case .lever:
            block = LeverBlock(with: attributes).node
        case .piston:
            block = PistonBlock(with: attributes).node
        case .pistonHead:
            block = PistonHeadBlock(with: attributes).node
        case .pressurePlate:
            block = PressurePlateBlock(with: attributes).node
        case .rail:
            block = RailBlock(with: attributes).node
        case .redstone:
            block = RedstoneDustDotBlock(with: attributes).node
        case .repeater:
            block = RepeaterBlock(with: attributes).node
        case .sign,
             .wallSign:
            block = SignBlock(with: attributes).node
        case .slab:
            block = SlabBlock(with: attributes).node
        case .stairs:
            block = StairsBlock(with: attributes).node
        case .tallGrass:
            block = TallGrassBlock(with: attributes).node
        case .torch:
            block = TorchBlock(with: attributes).node
        case .trapDoor:
            block = TrapDoorBlock(attributes: attributes).node
        case .wall:
            block = WallBlock(with: attributes).node
        case .water:
            block = WaterBlock(with: attributes).node
        case .wood:
            block = WoodBlock(with: attributes).node
        }
        
        if let block = block {
            applyAttributes(to: block)
        }
        
        return block
    }
    
    func applyAttributes(to block: SCNNode) {
        switch attributes.blockType {
        case .block:
            block.applyDirectionAttribute(attributes: attributes)
        default:
            break
        }
        
        if attributes.axis != .none {
            block.applyAxisAttribute(attributes: attributes)
        }
    }
    
    func applyDirectionAttribute(to block: SCNNode) {
        switch attributes.facing {
        case .up:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .down:
            guard attributes.blockType != .hopper else {
                break
            }
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: CGFloat(radial), y: 0, z: 0, duration: 0))
        case .north:
            // should default to facing north
            break
        case .south:
            let radial = GLKMathDegreesToRadians(180)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .east:
            let radial = GLKMathDegreesToRadians(-90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .west:
            let radial = GLKMathDegreesToRadians(90)
            block.runAction(SCNAction.rotateBy(x: 0, y: CGFloat(radial), z: 0, duration: 0))
        case .none:
            break
        }
    }
    
    func applyAxisAttribute(to block: SCNNode) {
        switch attributes.axis {
        case .x:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: 0, y: 0, z: radial, duration: 0))
        case .y:
            // default
            break
        case .z:
            let radial = CGFloat(GLKMathDegreesToRadians(90))
            block.runAction(SCNAction.rotateBy(x: radial, y: 0, z: 0, duration: 0))
        case .none:
            break
        }
    }
}
