//
//  SHA224Tests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import XCTest
@testable import CryptoKit

class SHA224Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHA224() {
        let testStrings = [
            "",
            "The quick brown fox jumps over the lazy dog",
            "The quick brown fox jumps over the lazy dog.",
        ]
        
        let resultStrings = [
            "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f",
            "730e109bd7a8a32b1cb9d9a09aa2325d2430587ddbc0c38bad911525",
            "619cba8e8e05826e9b8c519c0a5c68f4fb653e8a3d8aa04bb2c8cd4c",
        ]
        
        for i in 0..<testStrings.count {
            XCTAssertEqual(testStrings[i].sha224().hexString, resultStrings[i])
        }
    }
}


extension String {
    func sha224() -> Data {
        return self.data(using: .utf8)!.digest(using: .sha224)
    }
}

