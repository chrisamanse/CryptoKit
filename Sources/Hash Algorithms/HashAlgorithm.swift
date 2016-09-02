//
//  HashAlgorithm.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public protocol HashAlgorithm {
    static var blockSize: UInt { get }
    static func digest(_ message: Data) -> Data
}

public extension HashAlgorithm {
    public static var blockSize: UInt {
        return 64
    }
}
