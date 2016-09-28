import Foundation
import XCTest
@testable import CryptoKitTests

XCTMain([
     testCase(HashFunctionTests.allTests),
     testCase(MD5Tests.allTests),
     testCase(SHA1Tests.allTests),
     testCase(SHA2Tests.allTests)
])
