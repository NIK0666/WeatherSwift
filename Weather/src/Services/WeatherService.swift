//
//  OpenWeatcherMap_API.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherService: ServiceProtocol {
    let APPID = "d7243185ea838ab9cb868d1c7d7da283"
    let host = "https://api.openweathermap.org/data"
    let api_version = "2.5"
    
    private var forecast: ForecastResponse?
    private var weather: WeatherResponce?
    
    var responsedCnt = 0
    
    func request(by coord: Coord, sucessed: @escaping ItemClosure<(WeatherResponce,ForecastResponse)>, error: @escaping ItemClosure<Error>) {
        responsedCnt = 0
        
        request(postfix: "/forecast", parameters: ["lat": coord.lat, "lon": coord.lon, "APPID": APPID, "cnt": 8], failure: { error in
            print("error!!!")
        }) { data in
            do {
                self.forecast = try self.decoder.decode(ForecastResponse.self, from: data)
                self.responsedCnt += 1
                if self.responsedCnt > 1 {
                    sucessed((self.weather!, self.forecast!))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        request(postfix: "/weather", parameters: ["lat": coord.lat, "lon": coord.lon, "APPID": APPID], failure: { error in
            print("error!!!")
        }) { data in
            
            do {
                self.weather = try self.decoder.decode(WeatherResponce.self, from: data)
                self.responsedCnt += 1
                if self.responsedCnt > 1 {
                    sucessed((self.weather!, self.forecast!))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
