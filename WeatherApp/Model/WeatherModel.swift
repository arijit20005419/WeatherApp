//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by comviva on 17/02/22.
//

import Foundation

struct OpenWeather : Codable{
    var weatherData : [WeatherData]
}

struct WeatherData : Codable{
    var lat : String
    var lon : String
    var timezone : String
    var current : Current
//    var hourly : [Current]
//    var daily : [Daily]
}


// current or hourly  -> Same struct
struct Current : Codable{
    var temp : Double
    var humidity : Double
    var wind_speed : Double
    var weather : [Weather]
}

//struct Hourly : Codable{
//
//}

// daily
struct Daily : Codable{
    var temp : [Temp]
    var weather : [Weather]
}

struct Temp : Codable{
    var min : Double
    var max : Double
}

struct Weather : Codable{
    var icon : String
}
