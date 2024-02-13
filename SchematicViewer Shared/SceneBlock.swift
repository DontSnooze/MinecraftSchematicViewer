//
//  SceneBlock.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/12/24.
//

import Foundation
import SceneKit

class SceneBlock {
    class func createBlock() -> SCNNode {
        let g = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.05)
        
        let brick = SCNNode(geometry: g)
        
        brick.name = "brick"
        
        #if !targetEnvironment(simulator)
        brick.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(node: brick, options: nil))
        brick.physicsBody?.contactTestBitMask = ColliderType.ship.rawValue
        brick.physicsBody?.categoryBitMask = ColliderType.brick.rawValue
        brick.physicsBody?.mass = 1.0
        brick.physicsBody?.friction = 0
        brick.physicsBody?.restitution = 0
        brick.physicsBody?.rollingFriction = 0
        brick.physicsBody?.damping = 0
        brick.physicsBody?.angularDamping = 0
        brick.physicsBody?.charge = 0
        brick.physicsBody?.isAffectedByGravity = false
        #endif
        
        brick.geometry?.firstMaterial?.transparency = 0.75
        
        brick.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        //        brick.geometry?.firstMaterial?.reflective.contents = UIColor.black
        
        let brickColor = UIColor.cyan
        brick.geometry?.firstMaterial?.diffuse.contents = brickColor
        
        return brick
    }
}
