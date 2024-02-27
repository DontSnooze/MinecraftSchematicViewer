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
    static func parseNbt(path: String, completion: @escaping (NBT) -> Void) {
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        
        DispatchQueue.global(qos: .background).async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
            let eventLoop = group.next()
            
            let allocator = ByteBufferAllocator()
            let nbtfile = try! NBTFile(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator)
            
            // legacy MC schematic
//            let nbt = try! nbtfile.read(path: Bundle.main.path(forResource: "AmosBedrockCowFarmV2", ofType: "schematic") ?? "", eventLoop: eventLoop, gzip: true).wait()
            
            let nbt = try! nbtfile.read(path: path, eventLoop: eventLoop, gzip: true).wait()
            
            completion(nbt)
        }
    }
    
    static func parseNbt(completion: @escaping (NBT) -> Void) {
        //            let hopperFileName = "hopper_s_e_n_w_dwn"
//        let stairsFileName = "stairs_n_w_s_e_upsdwn"
        //            let signFileName = "sign_s_e_n_w_stand"
//        let chestFileName = "chest_s_e_n_w_dble"
//        let testFileName = "futHouse9"
        let testFileName = "redstone_and_doors"
        let path = Bundle.main.path(forResource: testFileName, ofType: "schem") ?? ""
        
        parseNbt(path: path) { nbt in
            completion(nbt)
        }
    }
    
    static func parseTestNbtFile() async -> NBT? {
        //            let hopperFileName = "hopper_s_e_n_w_dwn"
//        let stairsFileName = "stairs_n_w_s_e_upsdwn"
        //            let signFileName = "sign_s_e_n_w_stand"
//        let chestFileName = "chest_s_e_n_w_dble"
        let testFileName = "futHouse9"
        let path = Bundle.main.path(forResource: testFileName, ofType: "schem") ?? ""
        
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let eventLoop = group.next()
        
        let allocator = ByteBufferAllocator()
        let nbtfile = try! NBTFile(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator)
        
        guard let nbt = try? await nbtfile.read(path: path, eventLoop: eventLoop, gzip: true).get() else {
            return nil
        }
        
        return nbt
    }
}
