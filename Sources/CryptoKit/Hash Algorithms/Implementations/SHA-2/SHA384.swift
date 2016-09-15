//
//  SHA384.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation

public enum SHA384: SHA2Variant {
    public static var outputSize: UInt {
        return 48
    }
    
    public static var blockSize: UInt {
        return SHA512.blockSize
    }
    
    public static var initializationVector: [UInt64] {
        return [
            0xcbbb9d5dc1059ed8, 0x629a292a367cd507, 0x9159015a3070dd17, 0x152fecd8f70e5939,
            0x67332667ffc00b31, 0x8eb44a8768581511, 0xdb0c2e0d64f98fa7, 0x47b5481dbefa4fa4
        ]
    }
    
    public static var kConstants: [UInt64] {
        return SHA512.kConstants
    }
    
    public static var s0ShiftAndRotateAmounts: (UInt64, UInt64, UInt64) {
        return SHA512.s0ShiftAndRotateAmounts
    }
    public static var s1ShiftAndRotateAmounts: (UInt64, UInt64, UInt64) {
        return SHA512.s1ShiftAndRotateAmounts
    }
    
    public static var S0ShiftAndRotateAmounts: (UInt64, UInt64, UInt64) {
        return SHA512.S0ShiftAndRotateAmounts
    }
    public static var S1ShiftAndRotateAmounts: (UInt64, UInt64, UInt64) {
        return SHA512.S1ShiftAndRotateAmounts
    }
    
    public static func finalize(vector: [UInt64]) -> Data {
        return vector.dropLast(2).reduce(Data()) { $0 + Data(from: $1.bigEndian) }
    }
}
