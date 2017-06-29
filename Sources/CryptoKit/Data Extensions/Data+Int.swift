//
//  Data+Int.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

extension Data {
    /// [Swift 4.0] Integer protocol was removed. Use BinaryInteger insted. 
    init<T: BinaryInteger>(from value: T) {
        // Allocate a value pointer (and make sure it's always deallocated at end of scope
        let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer {
            valuePointer.deallocate(capacity: 1)
        }
        
        valuePointer.pointee = value
        
        let bytesPointer = valuePointer.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout<UInt8>.size) { $0 }
        
        self.init(bytes: bytesPointer, count: MemoryLayout<T>.size)
    }
}
