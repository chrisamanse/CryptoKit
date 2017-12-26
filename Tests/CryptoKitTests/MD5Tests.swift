//
//  MD5Tests.swift
//  CryptoKitTests
//
//  Created by Chris Amanse on 7/5/17.
//

import XCTest
import CryptoKit

class MD5Tests: XCTestCase {
    func testOutputBytesSize() {
        XCTAssertEqual(MD5().outputBytesSize, 16)
    }
    
    func testBlockBytesSize() {
        XCTAssertEqual(MD5().blockBytesSize, 64)
    }
    
    func testInitializationVector() {
        XCTAssertEqual(MD5().initializationVector, [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476])
    }
    
    func testNumberOfRounds() {
        XCTAssertEqual(MD5().numberOfRounds, 64)
    }
    
    func testPerRoundShiftAmounts() {
        XCTAssertEqual(MD5().perRoundShiftAmounts.count, 64)
        XCTAssertEqual(MD5().perRoundShiftAmounts, [
            7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
            5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
            4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
            6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21
            ])
    }
    
    func testPerRoundConstants() {
        XCTAssertEqual(MD5().perRoundConstants.count, 64)
        XCTAssertEqual(MD5().perRoundConstants, (0 ..< 64).map { UInt32(floor(4294967296 * abs(sin(Double($0) + 1)))) })
    }
    
    func testDigestOfEmptyData() {
        let md5 = MD5()
        let emptyData = Data()
        
        XCTAssertEqual(md5.digest(emptyData).hexString, "d41d8cd98f00b204e9800998ecf8427e")
    }
    
    func testDigestOfSmallLetterA() {
        let md5 = MD5()
        let message = "a".data(using: .utf8)
        let digest = message.map { md5.digest($0) }
        
        XCTAssertNotNil(message)
        XCTAssertEqual(digest?.hexString, "0cc175b9c0f1b6a831c399e269772661")
        
        // TODO: Create MerkleDamgardUtility utility functions?
        // MerkleDamgardUtility.applyPadding(to:) -> Data
    }
    
    static var allTests : [(String, (MD5Tests) -> () throws -> Void)] {
        return [
            ("testOutputBytesSize", testOutputBytesSize),
            ("testBlockBytesSize", testBlockBytesSize)
        ]
    }
}
