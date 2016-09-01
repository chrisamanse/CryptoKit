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
    
    public static var sha224: Data.HashFunction {
        return SHA224.hashFunction
    }
    
    public static var sha256: Data.HashFunction {
        return SHA256.hashFunction
    }
    
    public static var sha384: Data.HashFunction {
        return SHA384.hashFunction
    }
    
    public static var sha512: Data.HashFunction {
        return SHA512.hashFunction
    }
}
