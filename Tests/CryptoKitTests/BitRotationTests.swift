//
//  BitRotationTests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 7/3/17.
//

import XCTest
import CryptoKit

class BitRotationTests: XCTestCase {
    func testRotateZeroBits() {
        XCTAssertEqual(1 <<< 0, 1)
        XCTAssertEqual(1 >>> 0, 1)
        XCTAssertEqual(9 >>> 0, 9)
        XCTAssertEqual(9 <<< 0, 9)
    }
    
    func testRotateBits() {
        let one: UInt8 = 0b0000_0001
        
        XCTAssertEqual(one >>> 1, 0b1000_0000)
        XCTAssertEqual(one <<< 1, 0b0000_0010)
        XCTAssertEqual(one >>> 3, 0b0010_0000)
        XCTAssertEqual(one <<< 3, 0b0000_1000)
        
        let five: UInt8 = 0b0000_0101
        
        XCTAssertEqual(five >>> 0, 5)
        XCTAssertEqual(five <<< 0, 5)
        XCTAssertEqual(five >>> 1, 0b1000_0010)
        XCTAssertEqual(five <<< 1, 0b0000_1010)
        XCTAssertEqual(five >>> 6, 0b0001_0100)
        XCTAssertEqual(five <<< 6, 0b0100_0001)
    }
    
    static var allTests : [(String, (BitRotationTests) -> () throws -> Void)] {
        return [
            ("testRotateZeroBits", testRotateZeroBits),
            ("testRotateBits", testRotateBits)
        ]
    }
}
