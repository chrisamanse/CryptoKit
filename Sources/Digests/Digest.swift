//
//  Digest.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import Foundation

public struct Digest {
    public struct Algorithm {
        public var digestFunction: (Data) -> Data
        
        public init(digestFunction: @escaping (Data) -> Data) {
            self.digestFunction = digestFunction
        }
    }
    
    public static func generate(from message: Data, using algorithm: Digest.Algorithm) -> Data {
        return algorithm.digestFunction(message)
    }
    
    private init() {}
}
