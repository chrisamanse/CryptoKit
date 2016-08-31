//
//  BitwiseRotate.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

extension UInt32 {
    func rotateLeft(by amount: UInt32) -> UInt32 {
        guard amount != 0 else {
            return self
        }
        
        let shift = amount % 32
        
        return (self << shift) | (self >> (32 - shift))
    }
    
    func rotateRight(by amount: UInt32) -> UInt32 {
        guard amount != 0 else {
            return self
        }
        
        let shift = amount % 32
        
        return (self >> shift) | (self << (32 - shift))
    }
}
