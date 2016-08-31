//
//  SHA256.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public struct SHA256: HashAlgorithm, HashPreprocessor {
    public static func digest(_ message: Data) -> Data {
        // Get padded message
        let paddedMessage = self.preprocess(message: message, length: 64, endianess: .bigEndian)
        
        // Initialize hash values
        var h: [UInt32] = [
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        ]
        
        let k = kConstants()
        
        // Divide into 512-bit (64-byte) chunks
        // Since data length is 0 bytes (mod 64), all chunks are 64 bytes
        let chunkLength = 64
        for index in stride(from: paddedMessage.startIndex, to: paddedMessage.endIndex, by: chunkLength) {
            // Get 512-bit chunk
            let chunk = paddedMessage.subdata(in: index ..< index + chunkLength)
            
            // Divide chunk into 32-bit words (512 is divisible by 32, thus all words are 32 bits)
            // Since 512 is divisible by 32, simply create array by converting the Data pointer to a UInt32 array pointer
            var w = chunk.withUnsafeBytes { (ptr: UnsafePointer<UInt32>) -> [UInt32] in
                // 512 / 32 = 16 words
                return Array(UnsafeBufferPointer(start: ptr, count: 16))
                }.map {
                    $0.bigEndian
            }
            
            // Extend 16 words to 64 words
            for i in 16..<64 {
                let s0 = w[i-15].rotateRight(by: 7) ^ w[i-15].rotateRight(by: 18) ^ (w[i-15] >> 3)
                let s1 = w[i-2].rotateRight(by: 17) ^ w[i-2].rotateRight(by: 19) ^ (w[i-2] >> 10)
                
                w.append(w[i-16] &+ s0 &+ w[i-7] &+ s1)
            }
            
            // Initialize hash value for this chunk
            var (A, B, C, D, E, F, G, H) = (h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7])
            
            for i in 0..<64 {
                let S1 = E.rotateRight(by: 6) ^ E.rotateRight(by: 11) ^ E.rotateRight(by: 25)
                let ch = (E & F) ^ ((~E) & G)
                let temp1 = H &+ S1 &+ ch &+ k[i] &+ w[i]
                let S0 = A.rotateRight(by: 2) ^ A.rotateRight(by: 13) ^ A.rotateRight(by: 22)
                let maj = (A & B) ^ (A & C) ^ (B & C)
                let temp2 = S0 &+ maj
                
                // Swap values
                (H, G, F, E, D, C, B, A) = (G, F, E, D &+ temp1, C, B, A, temp1 &+ temp2)
            }
            
            // Add current chunk's hash to result (allow overflow)
            let currentHash = [A, B, C, D, E, F, G, H]
            for i in 0..<h.count {
                h[i] = h[i] &+ currentHash[i]
            }
        }
        
        return h.map { Data(from: $0.bigEndian) }.reduce(Data()) { $0 + $1 }
    }
    
    internal static func kConstants() -> [UInt32] {
        return [
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
            0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
            0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
            0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
            0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
            0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
            0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
        ]
    }
}
