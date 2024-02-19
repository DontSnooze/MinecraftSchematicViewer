//
//  NBTParser.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/15/24.
//

import Foundation
import SceneKit
import NIO
import SwiftNBT

class NBTParser {
    static func parseNbt(completion: @escaping (NBT) -> Void) {
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        
        DispatchQueue.global(qos: .background).async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
            let eventLoop = group.next()
            
            let allocator = ByteBufferAllocator()
            let nbtfile = try! NBTFile(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator)
            
//            let hopperFileName = "hopper_s_e_n_w_dwn"
            let stairsFileName = "stairs_n_w_s_e_upsdwn"
//            let signFileName = "sign_s_e_n_w_stand"
            
//            let nbt = try! nbtfile.read(path: Bundle.main.path(forResource: "AmosBedrockCowFarmV2", ofType: "schematic") ?? "", eventLoop: eventLoop, gzip: true).wait()
            
            let nbt = try! nbtfile.read(path: Bundle.main.path(forResource: stairsFileName, ofType: "schem") ?? "", eventLoop: eventLoop, gzip: true).wait()
            
            completion(nbt)
        }
    }
}
