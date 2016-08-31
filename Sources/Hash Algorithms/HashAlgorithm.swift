//
//  HashAlgorithm.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public protocol HashAlgorithm {
    static func digest(_ message: Data) -> Data
}
