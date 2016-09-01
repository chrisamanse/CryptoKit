//
//  SHA224.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation

public struct SHA224: SHA2Variant {
    public static var endianess: Endianess {
        return .bigEndian
    }
    
    public static var initialHashValues: [UInt32] {
        return [
            0xc1059ed8, 0x367cd507, 0x3070dd17, 0xf70e5939,
            0xffc00b31, 0x68581511, 0x64f98fa7, 0xbefa4fa4
        ]
    }
    
    public static func combine(hashValues: [UInt32]) -> Data {
        return hashValues.dropLast().reduce(Data()) { $0 + Data(from: $1.bigEndian) }
    }
}
