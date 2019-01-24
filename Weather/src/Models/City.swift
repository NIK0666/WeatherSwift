//
//  City.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    @objc dynamic var country: String!
    @objc dynamic var name: String!
    @objc dynamic var lon = 0.0
    @objc dynamic var lat = 0.0
    
    func fullLocation() -> String {
        return "\(name!), \(country!)"
    }
}
