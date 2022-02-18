//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by comviva on 17/02/22.
//

import Foundation

struct OpenWeather : Codable{
    var timezone : String
    var current : Current
    var hourly : [Current]
    var daily : [Daily]
}

// current or hourly  -> Same struct
struct Current : Codable{
    var dt : Int
    var temp : Double                 //curent temprature
    var feels_like : Double           //accurate temprature
    var pressure : Int                //pressure
    var humidity : Int                //Humidity
    var wind_speed : Double           //wind speed
    var visibility : Int               //visibility
    var weather : [Weather]
}

// daily
struct Daily : Codable{
    var dt : Int
    var temp : Temperature
    var weather : [Weather]
}

struct Temperature : Codable{
    var min : Double
    var max : Double
}

struct Weather : Codable{
    var icon : String
}



//struct Hourly : Codable{
//
//}
