//
//  SHA224.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation

public enum SHA224: SHA2Variant {
    public static var outputSize: UInt {
        return 28
    }
    public static var blockSize: UInt {
        return 64
    }
    
    public static var kConstants: [UInt32] {
        return SHA256.kConstants
    }
    
    public static var s0ShiftAndRotateAmounts: (UInt32, UInt32, UInt32) {
        return SHA256.s0ShiftAndRotateAmounts
    }
    
    public static var s1ShiftAndRotateAmounts: (UInt32, UInt32, UInt32) {
        return SHA256.s1ShiftAndRotateAmounts
    }
    
    public static var S0ShiftAndRotateAmounts: (UInt32, UInt32, UInt32) {
        return SHA256.S0ShiftAndRotateAmounts
    }
    
    public static var S1ShiftAndRotateAmounts: (UInt32, UInt32, UInt32) {
        return SHA256.S1ShiftAndRotateAmounts
    }
    
    public static var initializationVector: [UInt32] {
        return [
            0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
            0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4
        ]
    }
    
    public static func finalize(vector: [UInt32]) -> Data {
        return vector.dropLast().reduce(Data()) { $0 + Data(from: $1.bigEndian) }
    }
}
