//
//  Data+hashings.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import Foundation

public extension Data.Hashing {
    public static var md5: Data.Hashing {
        return MD5.hashing
    }
    
    public static var sha1: Data.Hashing {
        return SHA1.hashing
    }
    
    public static var sha224: Data.Hashing {
        return SHA224.hashing
    }
    
    public static var sha256: Data.Hashing {
        return SHA256.hashing
    }
    
    public static var sha384: Data.Hashing {
        return SHA384.hashing
    }
    
    public static var sha512: Data.Hashing {
        return SHA512.hashing
    }
}
