//
//  KMModelTests.swift
//  KituraManagerTests
//
//  Created by Andrew Halls on 17/11/17.
//

import XCTest
import KituraManager


struct Person : KMModel {
    func primaryKey() -> String? {
        return lastName + firstName
    }
    
    var firstName: String
    var lastName: String
    var age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
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
        
        let propertyNameList = propertyList.map({ $0.key })
        let expectedResult = ["firstName", "lastName", "age"]
        XCTAssertEqual(propertyNameList, expectedResult)
        
        let propertyTypeFirstName = propertyList[0].type
        let expectedResult2 = String.Type.self
        XCTAssert(typeCompare(propertyTypeFirstName,  expectedResult2))
        
        
        let propertyTypeAge = propertyList[2].type
        let expectedResult3 = Int.Type.self
        XCTAssert(typeCompare(propertyTypeAge,  expectedResult3))
        
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
