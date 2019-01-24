//
//  TimeZoneDBResponse.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation

struct TimeZoneResponse: Codable {
    var status: String
    var message: String
    var countryCode: String
    var countryName: String
    var zoneName: String
    var abbreviation: String
    var gmtOffset: Int
    var dst: String
    var zoneStart: Int
    var zoneEnd: Int
    var nextAbbreviation: String
    var timestamp: Int
    var formatted: String
}
