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
    
    func fetchData(lat : String, lon : String) {
        let apiURL = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=alerts,minutely&appid=\(apiId)"
        
        print(apiURL,"\n\n")
        
        guard let url = URL(string: apiURL) else{
            print("Failed")
            return
        }
        
        Session.default.request(url, method: .get,encoding: URLEncoding.default, requestModifier: nil).validate(statusCode: 200..<300).responseDecodable(of: [OpenWeather].self) { response in
            switch response.result {
            case .success(let data) :
                print(data)
            case .failure(let err) :
                print(err)
            }
        }
    }
}
