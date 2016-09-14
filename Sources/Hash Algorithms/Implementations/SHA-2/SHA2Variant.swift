//
//  SHA2Variant.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation

public protocol SHA2Variant: HashAlgorithm, MerkleDamgardConstructor {
    static var kConstants: [Self.BaseUnit] { get }
    
    static var s0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    static var s1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    
    static var S0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    static var S1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
}

public extension SHA2Variant {
    public static var endianess: Endianess {
        return .bigEndian
    }
    
    public static var rounds: UInt {
        return UInt(self.kConstants.count)
    }
    
    public static func compress(_ data: Data) -> [BaseUnit] {
        // Constants
        let k = self.kConstants
        var h = self.initializationVector
        
        // Rotate amounts
        let s0Amounts = self.s0ShiftAndRotateAmounts
        let s1Amounts = self.s1ShiftAndRotateAmounts
        let S0Amounts = self.S0ShiftAndRotateAmounts
        let S1Amounts = self.S1ShiftAndRotateAmounts
        
        // Divide into 512-bit (64-byte) chunks
        // Since data length is 0 bytes (mod 64), all chunks are 64 bytes
        let chunkLength = Int(self.blockSize)
        for index in stride(from: data.startIndex, to: data.endIndex, by: chunkLength) {
            // Get 512-bit chunk
            let chunk = data.subdata(in: index ..< index + chunkLength)
            
            // Divide chunk into 32-bit words (512 is divisible by 32, thus all words are 32 bits)
            // Since 512 is divisible by 32, simply create array by converting the Data pointer to a UInt32 array pointer
            let elementCount = chunkLength / MemoryLayout<BaseUnit>.size
            var w = chunk.withUnsafeBytes { (ptr: UnsafePointer<BaseUnit>) -> [BaseUnit] in
                    // 512 / 32 = 16 words
                    return Array(UnsafeBufferPointer(start: ptr, count: elementCount))
                }.map {
                    $0.bigEndian
                }
            
            // Extend 16 words to 64 words
            for i in 16 ..< Int(self.rounds) {
                let w15 = w[i-15]
                let s0 = (w15 >>> s0Amounts.0) ^ (w15 >>> s0Amounts.1) ^ (w15 >> s0Amounts.2)
                
                let w2 = w[i-2]
                let s1 = (w2 >>> s1Amounts.0) ^ (w2 >>> s1Amounts.1) ^ (w2 >> s1Amounts.2)
                
                w.append(w[i-16] &+ s0 &+ w[i-7] &+ s1)
            }
            
            // Initialize hash value for this chunk
            var (A, B, C, D, E, F, G, H) = (h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7])
            
            for i in 0 ..< Int(self.rounds) {
                let S1 = (E >>> S1Amounts.0) ^ (E >>> S1Amounts.1) ^ (E >>> S1Amounts.2)
                let ch = (E & F) ^ ((~E) & G)
                let temp1 = H &+ S1 &+ ch &+ k[i] &+ w[i]
                let S0 = (A >>> S0Amounts.0) ^ (A >>> S0Amounts.1) ^ (A >>> S0Amounts.2)
                let maj = (A & B) ^ (A & C) ^ (B & C)
                let temp2 = S0 &+ maj
                
                // Swap values
                H = G
                G = F
                F = E
                E = D &+ temp1
                D = C
                C = B
                B = A
                A = temp1 &+ temp2
            }
            
            // Add current chunk's hash to result (allow overflow)
            let currentHash = [A, B, C, D, E, F, G, H]
            
            for i in 0..<h.count {
                h[i] = h[i] &+ currentHash[i]
            }
        }
        
        return h
    }
}
