
import Foundation

// Structure for current day weather Data Structure


// starts here

struct WeatherDataResult : Codable{
    var current : currentWeatherData    // Fetching all the data related to current weather
    
}

struct currentWeatherData : Codable{
    
    var temp : Double                 //curent temprature
    var feels_like : Double           //accurate temprature
    var pressure : Int                //pressure
    var humidity : Int                //Humidity
    var wind_speed : Double           //wind speed
    var weather : [currweatherDesc]
}

struct currweatherDesc : Codable{
    var icon : String
}

//ends here

// structure for Weekly weather

// starts here

struct WeeklyWeatherDataResult : Codable{
    var daily : [DailyWeatherData]
}

struct DailyWeatherData : Codable{
    var dt : Int
    var temp : WeeklyTemprature
    var wind_speed : Double
    var weather : [weatherDesc]
}

struct weatherDesc:Codable{
    var icon : String
}

struct WeeklyTemprature : Codable{
    var min : Double
    var max : Double
    var day : Double
}

//ends here
