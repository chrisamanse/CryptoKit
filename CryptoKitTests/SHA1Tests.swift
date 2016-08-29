//
//  SHA1Tests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 29/08/2016.
//
//

import XCTest
@testable import CryptoKit

class SHA1Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHA1() {
        // Verification strings from RFC 3174
        XCTAssertEqual("abc".sha1().hexString, "a9993e364706816aba3e25717850c26c9cd0d89d")
        XCTAssertEqual("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq".sha1().hexString,
                       "84983e441c3bd26ebaae4aa1f95129e5e54670f1")
        XCTAssertEqual("a".sha1().hexString, "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
        XCTAssertEqual("0123456701234567012345670123456701234567012345670123456701234567".sha1().hexString,
                       "e0c094e867ef46c350ef54a7f59dd60bed92ae83")
        
    }
}

extension String {
    func sha1() -> Data {
        return SHA1.generateDigest(of: self.data(using: .utf8)!)
    }
}
