import XCTest
import Kitura
@testable import KituraManager

class KituraManagerTests: XCTestCase {
    public func testGet() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let mgr = KituraManager()
        mgr.setupRouter("GET", path: "/") { (req, resp) -> Bool in
            resp.send("Hello, World!")
            Kitura.stop()
            XCTAssertNil(resp.error)
            return true
        }
        Kitura.run()
    }
    
    static var allTests: [(String, (KituraManagerTests) -> () throws -> Void)] {
        return [
            ("testGet", testGet)
        ]
    }
}
