//
//  HashFunctionTests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 09/28/2016.
//
//

import XCTest
import CryptoKit

class HashFunctionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEquatable() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let md5: HashFunction = .md5
        
        XCTAssertEqual(md5, .md5)
        XCTAssertNotEqual(md5, .sha1)
        XCTAssertNotEqual(md5, .sha224)
        XCTAssertNotEqual(md5, .sha256)
        XCTAssertNotEqual(md5, .sha512)
        
        let sha1: HashFunction = .sha1
        
        XCTAssertEqual(sha1, .sha1)
        XCTAssertNotEqual(sha1, .md5)
        XCTAssertNotEqual(sha1, .sha224)
        XCTAssertNotEqual(sha1, .sha256)
        XCTAssertNotEqual(sha1, .sha512)
    }
    
    static var allTests : [(String, (HashFunctionTests) -> () throws -> Void)] {
        return [
            ("testEquatable", testEquatable),
        ]
    }
}
