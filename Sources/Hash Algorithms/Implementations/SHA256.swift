//
//  SHA256.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public struct SHA256: SHA2Variant {
    public static var endianess: Endianess {
        return .bigEndian
    }
}
