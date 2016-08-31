//
//  HashPreprocessor.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public enum Endianess {
    case bigEndian
    case littleEndian
}

public protocol HashPreprocessor {
    static var paddingLength: UInt { get }
    static var endianess: Endianess { get }
    
    static func preprocess(message: Data) -> Data
}

public extension HashPreprocessor {
    public static var paddingLength: UInt {
        return 64
    }
    public static var endianess: Endianess {
        return .littleEndian
    }
    
    public static func preprocess(message: Data) -> Data {
        let length = Int(paddingLength)
        
        // Create mutable copy of message
        var messageCopy = message
        
        // Append 1-bit and zeros until length of messageCopy in bits = 448 (mod 512)
        // 448 bits = 56 bytes, 512 bits = 64 bytes
        messageCopy.append(0x80)
        
        // Compute padded zeros count
        var paddedZerosCount = messageCopy.count % length
        
        let target = length - 8 // 8-bytes for length
        if paddedZerosCount <= 56 {
            paddedZerosCount = target - paddedZerosCount
        } else {
            paddedZerosCount = length - paddedZerosCount + target
        }
        
        // Append zeros
        messageCopy.append(contentsOf: Array(repeating: UInt8(0x00), count: paddedZerosCount))
        
        // Append origin length in bits as 8-byte Data
        let data: Data = {
            switch endianess {
            case .bigEndian:
                return Data(from: (UInt64(message.count) * 8).bigEndian)
            case .littleEndian:
                return Data(from: (UInt64(message.count) * 8))
            }
        }()
        
        messageCopy.append(data)
        
        return messageCopy
    }
}
