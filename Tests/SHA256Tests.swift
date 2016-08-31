//
//  SHA256Tests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 31/08/2016.
//
//

import XCTest
@testable import CryptoKit

class SHA256Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHA256() {
        let testStrings = [
            "abc",
            "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
            String(repeating: "a", count: 1000000),
            String(repeating: "01234567012345670123456701234567", count: 20)
        ]
        
        let resultStrings = [
            "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
            "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
            "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0",
            "594847328451bdfa85056225462cc1d867d877fb388df0ce35f25ab5562bfbb5"
        ]
        
        for i in 0..<testStrings.count {
            XCTAssertEqual(testStrings[i].sha256().hexString, resultStrings[i])
        }
    }
}

extension String {
    func sha256() -> Data {
        return self.data(using: .utf8)!.digest(using: .sha256)
    }
}
