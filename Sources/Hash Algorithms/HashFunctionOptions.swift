//
//  HashFunctionOptions.swift
//  CryptoKit
//
//  Created by Chris Amanse on 06/09/2016.
//
//

import Foundation

public extension HashFunction {
    /// MD5 hash function.
    public static var md5: HashFunction { return MD5.hashFunction }
    
    /// SHA-1 hash function.
    public static var sha1: HashFunction { return SHA1.hashFunction }
    
    /// SHA-224 hash function.
    public static var sha224: HashFunction { return SHA224.hashFunction }
    
    /// SHA-256 hash function.
    public static var sha256: HashFunction { return SHA256.hashFunction }
    
    /// SHA-384 hash function.
    public static var sha384: HashFunction { return SHA384.hashFunction }
    
    /// SHA-512 hash function.
    public static var sha512: HashFunction { return SHA512.hashFunction }
}
