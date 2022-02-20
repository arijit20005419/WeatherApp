//
//  ApiHandlerModel.swift
//  WeatherApp
//
//  Created by comviva on 17/02/22.
//

import Foundation
import Alamofire


class ApiHandlerModel{
    private init(){}
    
    static var instance = ApiHandlerModel()
    let apiId = "a623c991fa2218fa530343c93ec0cc9c"
    
    func fetchData(lat : String, lon : String, completion : @escaping (OpenWeather) -> Void){
        let apiURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=alerts,minutely&appid=\(apiId)"
        
        guard let url = URL(string: apiURL) else{
            print("Failed")
            return
        }
        
        Session.default.request(url).responseDecodable(of: OpenWeather.self) { (response) in
            if response.error == nil{
                switch response.result {
                case .success(let data) :
                    //                    print(data)
                    completion(data)
                case .failure(let err) :
                    print(err)
                    print(err.localizedDescription)
                }
            }
            else{
                print("Error: \(String(describing: response.error))")
            }
        }
    }
    
    
    func dowloadImg(imgUrl : String, completion : @escaping (Data) -> Void){
        if let url = URL(string: imgUrl){
            Session.default.download(url).responseData { imgData in
                switch imgData.result{
                case .success(let data):
                    print(data)
                    completion(data)
                case .failure(let err) :
                    print(err)
                }
            }
        }
    }
    
}
