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


    }
}
