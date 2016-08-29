//
//  Digest+Algorithms.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

public extension Digest.Algorithm {
    public static var md5: Digest.Algorithm {
        return Digest.Algorithm(digestFunction: MD5.generateDigest)
    }
    public static var sha1: Digest.Algorithm {
        return Digest.Algorithm(digestFunction: SHA1.generateDigest)
    }
}
