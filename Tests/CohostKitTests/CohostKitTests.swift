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
        let salt = try await getSalt(for: "example@example.com")
        
        XCTAssert(salt.count > 0)
    }
}
