//
//  NBTParser.swift
//  SchematicViewer
//
//  Created by Amos Todman on 2/15/24.
//

import SceneKit
import NIO
import SwiftNBT

struct NBTParser {
    static var isForDebug = false
    
    static func parseNbt(path: String) async -> NBT? {
        let threadPool = NIOThreadPool(numberOfThreads: 2)
        threadPool.start()
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let eventLoop = group.next()
        
        let allocator = ByteBufferAllocator()
        
        guard let nbtfile = try? NBTFile(io: NonBlockingFileIO(threadPool: threadPool), bufferAllocator: allocator) else {
            print("Could not create NBTFile buffer")
            return nil
        }
        
        guard let nbt = try? await nbtfile.read(path: path, eventLoop: eventLoop, gzip: true).get() else {
            print("could not create NBT from NBTFile")
            return nil
        }
        
        return nbt
    }
    
    static func parseBundleNbt(fileName: String = "redstone_and_doors") async -> NBT? {
        let path = Bundle.main.path(forResource: fileName, ofType: "schem") ?? ""
        let nbt = await parseNbt(path: path)
        return nbt
    }
    
    static func testParseBundleNbt(fileName: String = "redstone_and_doors") async -> String {
        var text = " - "
        guard
            let filePath = Bundle.main.path(forResource: fileName, ofType: "schem")
        else {
            return "error: filePath is nil"
        }
        
        do {
            text = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            text = "load error: \(error.localizedDescription)"
        }
        
        return text
    }
}
