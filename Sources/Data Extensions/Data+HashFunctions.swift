//
//  Data+HashFunctions.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public extension Data.HashFunction {
    public static var md5: Data.HashFunction {
        return MD5.hashFunction
    }
    
    public static var sha1: Data.HashFunction {
        return SHA1.hashFunction
    }
}
