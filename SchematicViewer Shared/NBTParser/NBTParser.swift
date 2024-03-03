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
    static var isForDebug = false
    
    static func parseNbt(path: String) async -> NBT {
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let eventLoop = group.next()
        
        let allocator = ByteBufferAllocator()
        guard let nbtfile = try? NBTFile(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator) else {
            fatalError("Could not create NBTFile buffer")
        }
        
        guard let nbt = try? await nbtfile.read(path: path, eventLoop: eventLoop, gzip: true).get() else {
            fatalError("could not create NBT from NBTFile")
        }
        
        return nbt
    }
    
    static func parseBundleNbt(fileName: String = "redstone_and_doors") async -> NBT {
        let path = Bundle.main.path(forResource: fileName, ofType: "schem") ?? ""
        
        let nbt = await parseNbt(path: path)
        return nbt
    }
}
