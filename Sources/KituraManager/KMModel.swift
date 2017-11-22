//
//  KMModel.swift
//  KituraManagerPackageDescription
//
//  Created by Andrew Halls on 17/11/17.
//

import Foundation
import Reflection
import SwiftKuery

public class KMModel: Table {
    public let primaryKey: String = ""
    
    /* TODO List
     * Should have db related operations.
     * Should contained relationship operation
     * Should contained primary key options.
     */
}

public protocol KMProperty {
    
}

public extension KMModel {
    
    public class var className: String {
        return String(describing: self).components(separatedBy: ".").first!
    }

    static func properties() -> [Property.Description] {
        do {
            let result =  try Reflection.properties(self)
            return result
        }
        catch {
            return []
        }
    }
}


