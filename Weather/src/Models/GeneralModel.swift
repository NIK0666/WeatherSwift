//
//  GeneralModel.swift
//  Weather
//
//  Created by NIKO on 24/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation

struct GeneralModel {
    let city: City?
    let currentLocation: Coord?
    let weather: WeatherResponce
    let forecast: ForecastResponse
    let timeZone: TimeZoneResponse
    
    init(city: City?, currentLocation: Coord?, weather: WeatherResponce, forecast: ForecastResponse, timeZone: TimeZoneResponse) {
        self.city = city
        self.currentLocation = currentLocation
        self.weather = weather
        self.forecast = forecast
        self.timeZone = timeZone
    }
}
