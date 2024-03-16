//
//  String+Extensions.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/16/24.
//

import Foundation

extension String {
    func slice(from: String, to: String) -> String? {
        guard let fromRange = from.isEmpty ? startIndex..<startIndex : range(of: from) else { return nil }
        guard let toRange = to.isEmpty ? endIndex..<endIndex : range(of: to, range: fromRange.upperBound..<endIndex) else { return nil }
        
        return String(self[fromRange.upperBound..<toRange.lowerBound])
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
