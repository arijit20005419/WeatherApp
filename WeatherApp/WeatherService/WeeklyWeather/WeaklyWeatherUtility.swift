
import Foundation

import Alamofire

class WeaklyWeatherUtility{
    
    let apiKey = "7e6fc1a97436cf9ba98b505a80d7ead4"
    
    private init(){
        
    }
    static var instance = WeaklyWeatherUtility()
    
        func getWeaklyWeather(completion : @escaping (WeeklyWeatherDataResult) -> Void){
            
            let WeeklyWeatherurl = "https://api.openweathermap.org/data/2.5/onecall?lat=23.376398&lon=85.339291&exclude=minutely&appid=\(apiKey)&units=metric"
            
            guard let url = URL(string: WeeklyWeatherurl)else{
                return
            }
            
            
            
            Session.default.request(url).responseDecodable(of : WeeklyWeatherDataResult.self){
                (resp) in
                
                if resp.error == nil{
                    print("successfully called the url")
                    
                    switch resp.result{
                        
                    case .success(let data):
                        print("response received : \(data)")
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
