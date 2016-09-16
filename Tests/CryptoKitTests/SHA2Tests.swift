//
//  SHA2Tests.swift
//  CryptoKit
//
//  Created by Chris Amanse on 01/09/2016.
//
//

import Foundation
import XCTest
@testable import CryptoKit

class SHA2Tests: XCTestCase {
    let testStrings = [
        "abc",
        "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq",
        String(repeating: "a", count: 1000000),
        String(repeating: "01234567012345670123456701234567", count: 20)
    ]
    let test2For384and512 = "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSHA224() {
        // SHA224
        let sha224Results = testResults(for: .sha224)
        XCTAssertEqual(testStrings[0].sha2Hash(.sha224), sha224Results[0])
        XCTAssertEqual(testStrings[1].sha2Hash(.sha224), sha224Results[1])
        XCTAssertEqual(testStrings[2].sha2Hash(.sha224), sha224Results[2])
        XCTAssertEqual(testStrings[3].sha2Hash(.sha224), sha224Results[3])
    }
    func testSHA256() {
        // SHA256
        let sha256Results = testResults(for: .sha256)
        XCTAssertEqual(testStrings[0].sha2Hash(.sha256), sha256Results[0])
        XCTAssertEqual(testStrings[1].sha2Hash(.sha256), sha256Results[1])
        XCTAssertEqual(testStrings[2].sha2Hash(.sha256), sha256Results[2])
        XCTAssertEqual(testStrings[3].sha2Hash(.sha256), sha256Results[3])
    }
    func testSHA384() {
        // SHA384
        let sha384Results = testResults(for: .sha384)
        XCTAssertEqual(testStrings[0].sha2Hash(.sha384), sha384Results[0])
        XCTAssertEqual(test2For384and512.sha2Hash(.sha384), sha384Results[1])
        XCTAssertEqual(testStrings[2].sha2Hash(.sha384), sha384Results[2])
        XCTAssertEqual(testStrings[3].sha2Hash(.sha384), sha384Results[3])
    }
    func testSHA512() {
        // SHA512
        let sha512Results = testResults(for: .sha512)
        XCTAssertEqual(testStrings[0].sha2Hash(.sha512), sha512Results[0])
        XCTAssertEqual(test2For384and512.sha2Hash(.sha512), sha512Results[1])
        XCTAssertEqual(testStrings[2].sha2Hash(.sha512), sha512Results[2])
        XCTAssertEqual(testStrings[3].sha2Hash(.sha512), sha512Results[3])
    }
    
    fileprivate func testResults(for variant: SHA2Variants) -> [String] {
        let results: [String] = {
            switch variant {
            case .sha224: return [
                "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7",
                "75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525",
                "20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67",
                "567f69f168cd7844e65259ce658fe7aadfa25216e68eca0eb7ab8262",
                ]
            case .sha256: return [
                "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
                "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
                "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0",
                "594847328451bdfa85056225462cc1d867d877fb388df0ce35f25ab5562bfbb5"]
            case .sha384: return [
                "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7",
                "09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039",
                "9d0e1809716474cb086e834e310a4a1ced149e9c00f248527972cec5704c2a5b07b8b3dc38ecc4ebae97ddd87f3d8985",
                "2fc64a4f500ddb6828f6a3430b8dd72a368eb7f3a8322a70bc84275b9c0b3ab00d27a5cc3c2d224aa6b61a0d79fb4596"
                ]
            case .sha512: return [
                "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f",
                "8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909",
                "e718483d0ce769644e2e42c7bc15b4638e1f98b13b2044285632a803afa973ebde0ff244877ea60a4cb0432ce577c31beb009c5c2c49aa2e4eadb217ad8cc09b",
                "89d05ba632c699c31231ded4ffc127d5a894dad412c0e024db872d1abd2ba8141a0f85072a9be1e2aa04cf33c765cb510813a39cd5a84c4acaa64d3f3fb7bae9",
                ]
            }
        }()
        
        return results
    }
    
    static var allTests : [(String, (SHA2Tests) -> () throws -> Void)] {
        return [
            ("testSHA224", testSHA224),
            ("testSHA256", testSHA256),
            ("testSHA384", testSHA384),
            ("testSHA512", testSHA512)
        ]
    }
}

fileprivate enum SHA2Variants {
    case sha224
    case sha256
    case sha384
    case sha512
}

fileprivate extension String {
    func sha2Hash(_ variant: SHA2Variants) -> String {
        let data = self.data(using: .utf8)!
        let hashData: Data = {
            switch variant {
            case .sha224: return data.digest(using: .sha224)
            case .sha256: return data.digest(using: .sha256)
            case .sha384: return data.digest(using: .sha384)
            case .sha512: return data.digest(using: .sha512)
            }
        }()
        
        return hashData.hexString
    }
}
