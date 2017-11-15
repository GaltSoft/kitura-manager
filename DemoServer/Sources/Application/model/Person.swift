//
//  Person.swift
//  AppPackageDescription
//
//  Created by YRH on 10/31/17.
//

import Foundation
import KituraManager

public struct Person: KMModel {
    var personId: Int = 0
    var fName: String = ""
    var lName: String
    
    public func primaryKey() -> String? {
        return "personId"
    }
}
