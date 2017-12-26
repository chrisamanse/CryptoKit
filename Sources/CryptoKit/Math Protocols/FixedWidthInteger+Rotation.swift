//
//  FixedWidthInteger+Rotation.swift
//  CryptoKit
//
//  Created by Chris Amanse on 7/3/17.
//

import Foundation

infix operator <<< : BitwiseShiftPrecedence
infix operator >>> : BitwiseShiftPrecedence

public extension FixedWidthInteger {
    public static func <<<(lhs: Self, rhs: Self) -> Self {
        guard rhs != Self(0) else {
            return lhs
        }
        
        let numberOfBits = Self(MemoryLayout<Self>.size * 8)
        
        return (lhs << rhs) | (lhs >> (numberOfBits - rhs))
    }
    
    public static func >>>(lhs: Self, rhs: Self) -> Self {
        guard rhs != Self(0) else {
            return lhs
        }
        
        let numberOfBits = Self(MemoryLayout<Self>.size * 8)
        
        return (lhs >> rhs) | (lhs << (numberOfBits - rhs))
    }
}
