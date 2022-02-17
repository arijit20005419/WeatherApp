
// This file contains all the methods related to current weather api

import Foundation

import Alamofire

class currentWeatherUtility{
    
    let apiKey = "7e6fc1a97436cf9ba98b505a80d7ead4"    // api key created using openWeather API
    
    private init(){
        
    }
    
    var latitude = "23.376398"
    var longitude = "85.339291"
    
    static var instance = currentWeatherUtility()
    
    func getCurrentWeather(completion : @escaping (WeatherDataResult) -> Void){
        
        let currentWeatherurl = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: currentWeatherurl)else{
            return
        }
        
        
        
        Session.default.request(url).responseDecodable(of : WeatherDataResult.self){
            (resp) in
            
            if resp.error == nil{
                print("successfully called the url")
                
                switch resp.result{
                    
                case .success(let data):
                    print("response received : \(data.current.temp)")
                    completion(data)
                case .failure(_):
                    print("Unable to fetch the data form the url ")
                }
                
            }
            
            else{
                print("\n\nFailed ... \(resp)")
            }
        }
        
    }
    
}

