import XCTest
import Foundation
import Kitura
import KituraNet
import HeliumLogger
import LoggerAPI
import KituraManager
import SwiftKuery
import SwiftKueryPostgreSQL

class CRUDTests: XCTestCase {
    static var port = 8080

    override func setUp() {
        super.setUp()
        
        let mgr = KituraManager()
        
//        mgr.registerModel(Person.self)
        mgr.registerModel(Person.self) { (router, path) -> String in
            return "Callback result"
        }
        
        Kitura.start()
    }
    
    override func tearDown() {
        Kitura.stop()
        super.tearDown()
    }
    
    func testCRUDStatic() {
        let arrRouter = ["POST", "GET", "PUT", "DELETE"]
        for router in arrRouter {
            self.testRoutersStatic(router)
        }
    }
    
    func testRoutersStatic(_ router: String) {
        let printExpectation = expectation(description: "The /route will serve static HTML content.")
        
        URLRequest(forTestWithMethod: router, route: "person")?
            .sendForTestingWithKitura { data, statusCode in
                if let getResult = String(data: data, encoding: String.Encoding.utf8){
                    XCTAssertEqual(statusCode, 200)
//                    XCTAssertTrue(getResult.contains("Person: \(router) request received."))
                    XCTAssertTrue(getResult.contains("Callback result"))
                } else {
                    XCTFail("Return value from / was nil!")
                }
                
                printExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testSwiftQuery() {
        let person = Person()
        let query = Select(from: person) // "SELECT * FROM tb_person"
        
        let pool = PostgreSQLConnection.createPool(
            host: "localhost",
            port: 5432,
            options: [.databaseName("db_kitura")],
            poolOptions: ConnectionPoolOptions(
                initialCapacity: 10,
                maxCapacity: 50,
                timeout: 10000
        ))
        
        guard let connection = pool.getConnection() else {
            XCTFail("Error: failed to get a connection.")
            return
        }
        connection.execute(query: query) { (queryResult) in
            if let error = queryResult.asError {
                XCTFail("Something went wrong \(error)")
            } else {
                guard queryResult.asResultSet != nil else {
                    XCTFail("Error: failed to get a resultSet.")
                    return
                }
                
                guard let rows = queryResult.asRows else {
                    XCTFail("Error: failed to get rows")
                    return
                }
                
                for row in rows {
                    XCTAssertNotNil(row["id"]!)
                    XCTAssertNotNil(row["fname"]!)
                    XCTAssertNotNil(row["lname"]!)
                    XCTAssertNotNil(row["age"]!)
                }
            }
        }
    }
}

private extension URLRequest {
    init?(forTestWithMethod method: String, route: String = "", body: Data? = nil) {
        if let url = URL(string: "http://localhost:\(CRUDTests.port)/" + route){
            self.init(url: url)
            addValue("application/json", forHTTPHeaderField: "Content-Type")
            httpMethod = method
            cachePolicy = .reloadIgnoringCacheData
            if let body = body {
                httpBody = body
            }
        } else {
            XCTFail("URL is nil...")
            return nil
        }
    }
    
    func sendForTestingWithKitura(fn: @escaping (Data, Int) -> Void) {
        
        guard let method = httpMethod, var path = url?.path, let headers = allHTTPHeaderFields else {
            XCTFail("Invalid request params")
            return
        }
        
        if let query = url?.query {
            path += "?" + query
        }
        
        let requestOptions: [ClientRequest.Options] = [.method(method), .hostname("localhost"), .port(8080), .path(path), .headers(headers)]
        
        let req = HTTP.request(requestOptions) { resp in
            
            if let resp = resp, resp.statusCode == HTTPStatusCode.OK || resp.statusCode == HTTPStatusCode.accepted {
                do {
                    var body = Data()
                    try resp.readAllData(into: &body)
                    fn(body, resp.statusCode.rawValue)
                } catch {
                    print("Bad JSON document received from Kitura-Starter.")
                }
            } else {
                if let resp = resp {
                    print("Status code: \(resp.statusCode)")
                    var rawUserData = Data()
                    do {
                        let _ = try resp.read(into: &rawUserData)
                        let str = String(data: rawUserData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                        print("Error response from Kitura-Starter: \(String(describing: str))")
                    } catch {
                        print("Failed to read response data.")
                    }
                }
            }
        }
        if let dataBody = httpBody {
            req.end(dataBody)
        } else {
            req.end()
        }
    }
}
extension CRUDTests {
    static var allTests : [(String, (CRUDTests) -> () throws -> Void)] {
        return [
            ("testCRUDStatic", testCRUDStatic),
            ("testSwiftQuery", testSwiftQuery)
        ]
    }
}   
