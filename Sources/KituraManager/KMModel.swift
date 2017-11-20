//
//  KMModel.swift
//  KituraManagerPackageDescription
//
//  Created by Andrew Halls on 17/11/17.
//

import Foundation
import Reflection


public protocol KMModel {
    func primaryKey() -> String?
    
    /* TODO List
     * Should have db related operations.
     * Should contained relationship operation
     * Should contained primary key options.
     */
}

public protocol KMProperty {
    
}

public extension KMModel {
    
    static var className: String {
        return  String(describing: type(of: self)).components(separatedBy: ".").first!
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


