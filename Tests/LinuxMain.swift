import XCTest
@testable import CryptoKitTests

XCTMain([
     testCase(MD5Tests.allTests),
     testCase(SHA1Tests.allTests),
     testCase(SHA2Tests.allTests)
])
