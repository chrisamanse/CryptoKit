//
//  Data+Digest.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

public extension Data {
    public func digest(using algorithm: Digest.Algorithm) -> Data {
        return Digest.generate(from: self, using: algorithm)
    }
}
