import XCTest
@testable import CohostKit

final class CohostKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CohostKit().text, "Hello, World!")
    }
}

@available(macOS 12.0, *)
final class CKAPITests: XCTestCase {
    func testGetSalt() async throws {
        // TODO: Mock APIs
        let salt: String = try await getSalt(for: "example@example.com")
        
        XCTAssertEqual(salt, "bqeZo1cm0IJOeXAAdOlbWA")
    }
    
    func testGetSaltBase64() async throws {
        // TODO: Mock APIs
        let salt: CKSalt = try await getSalt(for: "example@example.com")
        let decoded = try XCTUnwrap(salt.decodedSalt)
        
        XCTAssert(decoded.count > 0)
        
        let comparison = String(base64Encoding: decoded, options: .omitPaddingCharacter)
        XCTAssertEqual(salt.salt, comparison, "Obtained salt is not equal to reencoded salt in base64")
    }
}

@available(macOS 12.0, *)
final class CKSaltTests: XCTestCase {
    func testCKSaltFromJSON() throws {
        let model = try JSONDecoder().decode(CKSalt.self, from: Data("{\"salt\":\"bqeZo1cm0IJOeXA_dOlbWA\"}".utf8))
        // See: https://cohost.org/iliana/post/180187-eggbug-rs-v0-1-3-d
        XCTAssertEqual(model.salt, "bqeZo1cm0IJOeXAAdOlbWA")
    }
    
    func testCKSaltDecodes() throws {
        let model = try JSONDecoder().decode(CKSalt.self, from: Data("{\"salt\":\"bqeZo1cm0IJOeXA_dOlbWA\"}".utf8))
        
        let decoded = try XCTUnwrap(model.decodedSalt)
        
        XCTAssert(decoded.count > 0)
        
        let comparison = String(base64Encoding: decoded, options: .omitPaddingCharacter)
        XCTAssertEqual(model.salt, comparison, "Obtained salt is not equal to reencoded salt in base64")
    }
}

final class CryptoTests: XCTestCase {
    func testClientHashGeneration() throws {
        let hash: String = try CryptoUtils.generateHash(password: "example@example.com", salt: "bqeZo1cm0IJOeXA_dOlbWA")
        
        XCTAssertEqual(hash, "2hyxlL2DJYPlHBpU3ZnSiBKbFQVS+kw7aARL4JNnXqD1MN37vg6TWQJghiIB0Mnw9P9CChN7dqb1spjyVkwPYiTaDQ6uKcyHwN1KdeXzICdvFdRGmF1oVd2UHEkzy1WyfEA8kwdHT2+Vn19rzoj3Lef0V1Rb4or2FV3B7QsBaw0=")
    }
}


@available(macOS 12.0, *)
final class CKUserTests: XCTestCase {
    // TODO: Mock APIs
    
    // WARNING: Only run this test against the release build (swift test -c release -Xswiftc -enable-testing)
    // The CryptoSwift dependency is extremely slow in debug builds (and XCode does not let me run test in release mode)
    func testLogin() async throws {
        throw XCTSkip("Until APIs are mocked")
        _ = try await CKUser.login(email: "example@example.com", password: "example@example.com")
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
