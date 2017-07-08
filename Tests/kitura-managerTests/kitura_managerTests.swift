import XCTest
@testable import kitura_manager

class kitura_managerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(kitura_manager().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
