//
//  Data+Int.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

extension Data {
    init<T: FixedWidthInteger>(from value: T) {
        let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer {
            valuePointer.deallocate(capacity: 1)
        }
        
        valuePointer.pointee = value
        
        let bytesPointer = valuePointer.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout<UInt8>.size) { $0 }
        
        self.init(bytes: bytesPointer, count: MemoryLayout<T>.size)
    }
}
