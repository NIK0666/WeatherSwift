//
//  TimeZoneDB_API.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation

class TimeZoneService: ServiceProtocol {
    var APPID: String = "ZIV3SN0MP9YI"
    var host: String = "https://api.timezonedb.com"
    var api_version: String = "v2.1"
    
    private var time: TimeZoneResponse?
    
    func request(by coord: Coord, complition: @escaping ItemClosure<TimeZoneResponse>, failure: @escaping ItemClosure<Error>) {
        time = nil
        request(postfix: "/get-time-zone", parameters: ["lng": coord.lon, "lat": coord.lat, "key": APPID, "by": "position", "format": "json"], failure: { error in
            print(error.localizedDescription)
        }) { data in
            do {
                self.time = try self.decoder.decode(TimeZoneResponse.self, from: data)
                complition(self.time!)
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
