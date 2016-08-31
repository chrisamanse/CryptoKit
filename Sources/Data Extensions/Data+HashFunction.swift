//
//  Data+HashFunction.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public extension Data {
    public struct HashFunction {
        public var algorithm: HashAlgorithm.Type
        
        public init(type: HashAlgorithm.Type) {
            self.algorithm = type
        }
    }
    
    public func digest(using hashFunction: HashFunction) -> Data {
        return hashFunction.algorithm.digest(self)
    }
}

public extension HashAlgorithm {
    static var hashFunction: Data.HashFunction {
        return Data.HashFunction(type: self)
    }
}
