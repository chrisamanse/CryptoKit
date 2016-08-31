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
    static func preprocess(message: Data, length: Int, endianess: Endianess) -> Data
}

public extension HashPreprocessor {
    public static func preprocess(message: Data, length: Int, endianess: Endianess = .littleEndian) -> Data {
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
