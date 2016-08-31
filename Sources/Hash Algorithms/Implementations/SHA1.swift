//
//  SHA1.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

public struct SHA1: HashAlgorithm, HashPreprocessor {
    public static func digest(_ message: Data) -> Data {
        // Create mutable copy of message
        let messageCopy = self.preprocess(message: message, length: 64, endianess: .bigEndian)
        
        // Initialize variables
        var a0: UInt32 = 0x67452301
        var b0: UInt32 = 0xefcdab89
        var c0: UInt32 = 0x98badcfe
        var d0: UInt32 = 0x10325476
        var e0: UInt32 = 0xC3D2E1F0
        
        // Divide into 512-bit (64-byte) chunks
        // Since data length is 0 bytes (mod 64), all chunks are 64 bytes
        let chunkLength = 64
        for index in stride(from: messageCopy.startIndex, to: messageCopy.endIndex, by: chunkLength) {
            // Get 512-bit chunk
            let chunk = messageCopy.subdata(in: index ..< index + chunkLength)
            
            // Divide chunk into 32-bit words (512 is divisible by 32, thus all words are 32 bits)
            // Since 512 is divisible by 32, simply create array by converting the Data pointer to a UInt32 array pointer
            var w = chunk.withUnsafeBytes { (ptr: UnsafePointer<UInt32>) -> [UInt32] in
                // 512 / 32 = 16 words
                return Array(UnsafeBufferPointer(start: ptr, count: 16))
                }.map {
                    $0.bigEndian
            }
            
            // Extend 16 words to 80 words
            for i in 16..<80 {
                w.append((w[i-3] ^ w[i-8] ^ w[i-14] ^ w[i-16]).rotateLeft(by: 1))
            }
            
            // Initialize hash value for this chunk
            var A = a0
            var B = b0
            var C = c0
            var D = d0
            var E = e0
            
            // Main loop
            for i in 0..<80 {
                let round = i / 20
                
                let F: UInt32
                let k: UInt32
                
                switch round {
                case 0:
                    F = (B & C) | ((~B) & D)
                    k = 0x5A827999
                case 1:
                    F = B ^ C ^ D
                    k = 0x6ED9EBA1
                case 2:
                    F = (B & C) | (B & D) | (C & D)
                    k = 0x8F1BBCDC
                case 3:
                    F = B ^ C ^ D
                    k = 0xCA62C1D6
                default:
                    F = 0
                    k = 0
                }
                
                let temp = A.rotateLeft(by: 5) &+ F &+ E &+ k &+ w[i]
                E = D
                D = C
                C = B.rotateLeft(by: 30)
                B = A
                A = temp
            }
            
            // Add current chunk's hash to result (allow overflow)
            a0 = a0 &+ A
            b0 = b0 &+ B
            c0 = c0 &+ C
            d0 = d0 &+ D
            e0 = e0 &+ E
        }
        
        return Data(from: a0.bigEndian) + Data(from: b0.bigEndian) + Data(from: c0.bigEndian)
            + Data(from: d0.bigEndian) + Data(from: e0.bigEndian)
    }
}
