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
        case .anvil:
            block = AnvilBlock(with: attributes).node
        case .bamboo:
            block = BambooBlock(with: attributes).node
        case .banner:
            block = BannerBlock(with: attributes).node
        case .bed:
            block = BedBlock(with: attributes).node
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
        case .decoratedPot:
            block = DecoratedPotBlock(with: attributes).node
        case .door:
            block = DoorBlock(with: attributes).node
        case .fence:
            block = FenceBlock(with: attributes).node
        case .fenceGate:
            block = FenceGateBlock(with: attributes).node
        case .flowerPot:
            block = FlowerPotBlock(with: attributes).node
        case .glassPane:
            block = GlassPaneBlock(attributes: attributes).node
        case .grassBlock:
            block = GrassBlock(with: attributes).node
        case .grindstone:
            block = GrindstoneBlock(with: attributes).node
        case .head:
            block = HeadBlock(with: attributes).node
        case .hopper:
            block = HopperBlock(with: attributes).node
        case .ladder:
            block = LadderBlock(attributes: attributes).node
        case .lantern:
            block = LanternBlock(with: attributes).node
        case .lectern:
            block = LecternBlock(with: attributes).node
        case .lever:
            block = LeverBlock(with: attributes).node
        case .pitcherPlant:
            block = PitcherPlantBlock(with: attributes).node
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
        case .vine:
            block = VineBlock(with: attributes).node
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
}
