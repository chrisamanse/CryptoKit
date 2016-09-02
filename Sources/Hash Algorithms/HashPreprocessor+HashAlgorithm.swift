//
//  HashPreprocessor+HashAlgorithm.swift
//  CryptoKit
//
//  Created by Chris Amanse on 02/09/2016.
//
//

import Foundation

public extension HashPreprocessor where Self: HashAlgorithm {
    static var paddingLength: UInt {
        return self.blockSize
    }
}
