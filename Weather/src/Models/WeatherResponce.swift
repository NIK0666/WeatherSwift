//
//  WeatherResponce.swift
//  Weather
//
//  Created by NIKO on 22/01/2019.
//  Copyright © 2019 NIKO. All rights reserved.
//

import Foundation


struct WeatherResponce: Codable {
    var coord: Coord?
    var weather: [Weather]
    var base: String?
    var main: Main
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var snow: Snow?
    var dt: Int
    var sys: Sys
    var id: Int?
    var name: String?
    var cod: Int?    
}

struct ForecastResponse: Codable {
    var cod: String
    var message: Double
    var cnt: Int
    var list: [WeatherResponce]
    var city: CityResponce
}

struct CityResponce: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var population: Int?
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}
struct Main: Codable {
    var temp: Double
    var pressure: Double
    var humidity: Double
    var tempMin: Double?
    var tempMax: Double?
}

struct Wind: Codable {
    var speed: Double
    var deg: Double?
}

struct Clouds: Codable {
    var all: Int
}

struct Snow: Codable {
    var threeH: Double?
}

struct Sys: Codable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}


