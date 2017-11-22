//
//  KMModelTests.swift
//  KituraManagerTests
//
//  Created by Andrew Halls on 17/11/17.
//

import XCTest
@testable import KituraManager
import SwiftKuery
import SwiftKueryPostgreSQL

public class Person : KMModel {
    let tableName = "tb_person"
    let id = Column("id")
    let firstName = Column("fName")
    let lastName = Column("lName")
    let age = Column("age")
}

func typeCompare(_ a: Any, _ b: Any) -> Bool {
    let aString = String(describing: type(of: a)).split(separator: ".")[0]
    let bString = String(describing: type(of: b)).split(separator: ".")[0]
    return aString == bString
}

class KMModelTests: XCTestCase {
    func testClassName() {
        let personClassName = Person.className
        let expectedResult = "Person"
        XCTAssertEqual(personClassName, expectedResult)
    }
    
    func testPropertyList() {
        let propertyList = Person.properties()
        ["tableName", "id", "firstName", "lastName", "age"].forEach { key in
            let item = propertyList.filter { $0.key == key }.first
            XCTAssertNotNil(item, "OK!")
        }
    }
}

extension KMModelTests {
    public static var allTests: [(String, (KMModelTests) -> () throws -> Void)] {
        return [
            ("testClassName", testClassName),
            ("testPropertyList", testPropertyList),
        ]
    }
}
