//
//  Data+Hashing.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public extension Data {
    public struct Hashing {
        public var algorithm: HashAlgorithm.Type
        
        public init(type: HashAlgorithm.Type) {
            self.algorithm = type
        }
    }
    
    public func digest(using hashing: Hashing) -> Data {
        return hashing.algorithm.digest(self)
    }
}

public extension HashAlgorithm {
    static var hashing: Data.Hashing {
        return Data.Hashing(type: self)
    }
}
