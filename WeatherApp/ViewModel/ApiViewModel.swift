//
//  ApiViewModel.swift
//  WeatherApp
//
//  Created by comviva on 17/02/22.
//

import Foundation

class ApiViewModel{
    let apiHandlerModel = ApiHandlerModel.instance
    var finalData : OpenWeather?
    
    func getData(lati : String, longi : String, completion : @escaping (OpenWeather?) -> Void) {
        apiHandlerModel.fetchData(lat: lati, lon: longi) { data in
//            self.finalData = data
            completion(data)
        }
    }
//
//    func imageDownload(url : String, completion : @escaping (Data?) -> Void){
//        apiHandlerModel.dowloadImg(imgUrl: url) { data in
//            completion(data)
//        }
//    }
    
    
    
}
