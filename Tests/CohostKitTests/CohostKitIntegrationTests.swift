//
//  CohostKitIntegrationTests.swift
//  
//
//  Created by Angelo Chaves on 2022-11-06.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import CohostKit

@available(macOS 12.0, *)
final class CohostKitIntegrationTests: XCTestCase {
    func testGetSalt() async throws {
        let salt: String = try await getSalt(for: "example@example.com")
        
        XCTAssertEqual(salt, "bqeZo1cm0IJOeXAAdOlbWA")
    }
    
    func testGetSaltBase64() async throws {
        
        let salt: CKSalt = try await getSalt(for: "example@example.com")
        let decoded = try XCTUnwrap(salt.decodedSalt)
        
        XCTAssert(decoded.count > 0)
        
        let comparison = String(base64Encoding: decoded, options: .omitPaddingCharacter)
        XCTAssertEqual(salt.salt, comparison, "Obtained salt is not equal to reencoded salt in base64")
    }
    
    // WARNING: Only run this test against the release build (swift test -c release -Xswiftc -enable-testing)
    // The CryptoSwift dependency is extremely slow in debug builds (and XCode does not let me run test in release mode)
    func testLogin() async throws {
        throw XCTSkip("Until there is a way to configure a test account to login")
        _ = try await CKUser.login(email: "test@example.com", password: "test@example.com")
    }
    
    // WARNING: Only run this test against the release build (swift test -c release -Xswiftc -enable-testing)
    // The CryptoSwift dependency is extremely slow in debug builds (and XCode does not let me run test in release mode)
    func testIncorrectLogin() async throws {
        throw XCTSkip("For now until errors are properly reported")
        do {
            _ = try await CKUser.login(email: "example@example.com", password: "example@example.com")
            XCTFail("This call should throw an error.")
        } catch {
            // TODO: proper error checking
            XCTAssertNotNil(error)
        }
    }
}

