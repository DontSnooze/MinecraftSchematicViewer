//
//  SVNode.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/11/24.
//

import SceneKit

protocol SVNode {
    var attributes: NodeBlockAttributes { get set }
    var node: SCNNode { get set }
    
    func applyAttributes()
}
