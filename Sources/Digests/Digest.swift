//
//  Digest.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

public enum Digest {
    public struct Algorithm {
        fileprivate let digestFunction: (Data) -> Data
        
        public init(digestFunction: @escaping (Data) -> Data) {
            self.digestFunction = digestFunction
        }
    }
    
    public static func generate(from message: Data, using algorithm: Digest.Algorithm) -> Data {
        return algorithm.digestFunction(message)
    }
}

public protocol DigestCapable {
    static func generateDigest(of message: Data) -> Data
}
