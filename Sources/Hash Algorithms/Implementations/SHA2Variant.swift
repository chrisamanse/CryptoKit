//
//  SHA2Variant.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation

public protocol SHA2Variant: HashAlgorithm, HashPreprocessor {
    associatedtype BaseUnit: UnsignedInteger, BitwiseOperations, ShiftOperations,
        RotateOperations, ExpressibleByInt, EndianRepresentable
    
    static var kConstants: [BaseUnit] { get }
    static var initialHashValues: [BaseUnit] { get }
    
    static var s0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    static var s1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    
    static var S0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    static var S1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) { get }
    
    static func combine(hashValues: [BaseUnit]) -> Data
    
    static func generateHashValues(from message: Data) -> [BaseUnit]
}

public extension SHA2Variant {
    public static var kConstants: [BaseUnit] {
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
    
    public static var initialHashValues: [BaseUnit] {
        return [
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        ]
    }
    
    public static var s0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) {
        return (7, 18, 3)
    }
    public static var s1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) {
        return (17, 19, 10)
    }
    
    public static var S0ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) {
        return (2, 13, 22)
    }
    public static var S1ShiftAndRotateAmounts: (BaseUnit, BaseUnit, BaseUnit) {
        return (6, 11, 25)
    }
    
    public static func generateHashValues(from message: Data) -> [BaseUnit] {
        let paddedMessage = self.preprocess(message: message)
        
        // Constants
        let k = self.kConstants
        var h = self.initialHashValues
        
        let rounds = k.count
        
        // Rotate amounts
        let s0Amounts = self.s0ShiftAndRotateAmounts
        let s1Amounts = self.s1ShiftAndRotateAmounts
        let S0Amounts = self.S0ShiftAndRotateAmounts
        let S1Amounts = self.S1ShiftAndRotateAmounts
        
        // Divide into 512-bit (64-byte) chunks
        // Since data length is 0 bytes (mod 64), all chunks are 64 bytes
        let chunkLength = Int(self.paddingLength)
        for index in stride(from: paddedMessage.startIndex, to: paddedMessage.endIndex, by: chunkLength) {
            // Get 512-bit chunk
            let chunk = paddedMessage.subdata(in: index ..< index + chunkLength)
            
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
            for i in 16..<rounds {
                let w15 = w[i-15]
                let s0 = (w15 >>> s0Amounts.0) ^ (w15 >>> s0Amounts.1) ^ (w15 >> s0Amounts.2)
                
                let w2 = w[i-2]
                let s1 = (w2 >>> s1Amounts.0) ^ (w2 >>> s1Amounts.1) ^ (w2 >> s1Amounts.2)
                
                w.append(w[i-16] &+ s0 &+ w[i-7] &+ s1)
            }
            
            // Initialize hash value for this chunk
            var (A, B, C, D, E, F, G, H) = (h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7])
            
            for i in 0..<rounds {
                let S1 = (E >>> S1Amounts.0) ^ (E >>> S1Amounts.1) ^ (E >>> S1Amounts.2)
                let ch = (E & F) ^ ((~E) & G)
                let temp1 = H &+ S1 &+ ch &+ k[i] &+ w[i]
                let S0 = (A >>> S0Amounts.0) ^ (A >>> S0Amounts.1) ^ (A >>> S0Amounts.2)
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
        
        return h
    }
    
    public static func combine(hashValues: [BaseUnit]) -> Data {
        return hashValues.reduce(Data()) { (current, value) -> Data in
            current + Data(from: value.bigEndian)
        }
    }
    
    public static func digest(_ message: Data) -> Data {
        let finalHashValues = self.generateHashValues(from: message)
        
        return self.combine(hashValues: finalHashValues)
    }
}

public extension SHA2Variant where Self: HashPreprocessor, Self.BaseUnit == UInt64 {
    public static var paddingLength: UInt {
        return 128
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
        
        // Subtract 16 since last 128-bit (16-byte) data is the message length representation 
        let target = length - 16 // 8-bytes for length
        
        if paddedZerosCount < target {
            paddedZerosCount = target - paddedZerosCount
        } else {
            paddedZerosCount = length - paddedZerosCount + target
        }
        
        // Append zeros
        messageCopy.append(contentsOf: Array(repeating: UInt8(0x00), count: paddedZerosCount))
        
        // Append a 64-bit (8-byte) zero since algorithm demands a 128-bit representation of length
        messageCopy.append(Data(from: UInt64(0)))
        
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

