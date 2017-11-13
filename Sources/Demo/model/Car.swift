//
//  Car.swift
//  AppPackageDescription
//
//  Created by YRH on 10/31/17.
//

import Foundation
import KituraManager

public struct Car: KMModel {
    var carId: Int = 0
    var model: String
    var owner: String
    
    public func primaryKey() -> String? {
        return "carId"
    }
}
