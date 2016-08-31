//
//  ShiftOperations.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public protocol ShiftOperations {
    static func <<(lhs: Self, rhs: Self) -> Self
    static func >>(lhs: Self, rhs: Self) -> Self
}

extension UInt8: ShiftOperations {}
extension Int8: ShiftOperations {}
extension UInt16: ShiftOperations {}
extension Int16: ShiftOperations {}
extension UInt32: ShiftOperations {}
extension Int32: ShiftOperations {}
extension UInt64: ShiftOperations {}
extension Int64: ShiftOperations {}
extension UInt: ShiftOperations {}
extension Int: ShiftOperations {}
