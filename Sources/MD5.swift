//
//  MD5.swift
//  CryptoKit
//
//  Created by Chris Amanse on 28/08/2016.
//
//

import Foundation

public struct MD5 {
    public static func generateDigest(of message: Data) -> Data {
        // Create mutable copy of message
        var messageCopy = message
        
        // Append 1-bit and zeros until length of messageCopy in bits = 448 (mod 512)
        // 448 bits = 56 bytes, 512 bits = 64 bytes
        messageCopy.append(0x80)
        
        // Compute padded zeros count
        var paddedZerosCount = messageCopy.count % 64
        if paddedZerosCount <= 56 {
            paddedZerosCount = 56 - paddedZerosCount
        } else {
            paddedZerosCount = 64 - paddedZerosCount + 56
        }
        
        // Append zeros
        messageCopy.append(contentsOf: Array(repeating: UInt8(0x00), count: paddedZerosCount))
        
        // Append origin length in bits as 8-byte little-endian Data
        messageCopy.append(Data(from: UInt64(message.count) * 8))
        
        // Initialize variables
        var a0: UInt32 = 0x67452301
        var b0: UInt32 = 0xefcdab89
        var c0: UInt32 = 0x98badcfe
        var d0: UInt32 = 0x10325476
        
        // Divide into 512-bit (64-byte) chunks
        // Since data length is 0 bytes (mod 64), all chunks are 64 bytes
        let chunkLength = 64
        for index in stride(from: messageCopy.startIndex, to: messageCopy.endIndex, by: chunkLength) {
            // Get 512-bit chunk
            let chunk = messageCopy.subdata(in: index ..< index + chunkLength)
            
            // Divide chunk into 32-bit words (512 is divisible by 32, thus all words are 32 bits)
            // Since 512 is divisible by 32, simply create array by converting the Data pointer to a UInt32 array pointer
            let M: [UInt32] = chunk.withUnsafeBytes { (ptr: UnsafePointer<UInt32>) -> [UInt32] in
                // 512 / 32 = 16 words
                return Array(UnsafeBufferPointer(start: ptr, count: 16))
            }
            
            // Initiaize hash value for this chunk
            var A: UInt32 = a0
            var B: UInt32 = b0
            var C: UInt32 = c0
            var D: UInt32 = d0
            
            // Main loop
            for i in 0..<64 {
                // Divide 0..<64 into four rounds, i.e. 0..<16 = round 1, 16..<32 = round2, etc.
                let round = i / 16
                
                // Calculate F and g depending on round
                let F: UInt32
                let g: Int
                
                switch round {
                case 0:
                    F = (B & C) | ((~B) & D)
                    g = i
                case 1:
                    F = (D & B) | ((~D) & C)
                    g = ((5 * i) + 1) % 16
                case 2:
                    F = B ^ C ^ D
                    g = ((3 * i) + 5) % 16
                case 3:
                    F = C ^ (B | (~D))
                    g = (7 * i) % 16
                default:
                    F = 0
                    g = 0
                }
                
                // Swap values
                let newB = B &+ (A &+ F &+ K(i) &+ M[g]).rotateLeft(by: s(i))
                (D, C, B, A) = (C, B, newB, D)
            }
            
            // Add current chunk's hash to result (allow overflow)
            a0 = a0 &+ A
            b0 = b0 &+ B
            c0 = c0 &+ C
            d0 = d0 &+ D
        }
        
        // Combine
        return Data(from: a0) + Data(from: b0) + Data(from: c0) + Data(from: d0)
    }
    
    /// Get binary integer part of the sines of integers (Radians)
    static func K(_ i: Int) -> UInt32 {
        return UInt32(floor(4294967296 * abs(sin(Double(i) + 1))))
    }
    
    /// Get per-round shift amounts
    static func s(_ i: Int) -> UInt32 {
        let row = i / 16
        let column = i % 4
        
        switch row {
        case 0:
            switch column {
            case 0: return 7
            case 1: return 12
            case 2: return 17
            case 3: return 22
            default: return 0
            }
        case 1:
            switch column {
            case 0: return 5
            case 1: return 9
            case 2: return 14
            case 3: return 20
            default: return 0
            }
        case 2:
            switch column {
            case 0: return 4
            case 1: return 11
            case 2: return 16
            case 3: return 23
            default: return 0
            }
        case 3:
            switch column {
            case 0: return 6
            case 1: return 10
            case 2: return 15
            case 3: return 21
            default: return 0
            }
        default:
            return 0
        }
    }
}
