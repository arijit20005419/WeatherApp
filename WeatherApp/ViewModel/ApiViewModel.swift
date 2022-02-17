//
//  ApiViewModel.swift
//  WeatherApp
//
//  Created by comviva on 17/02/22.
//

import Foundation

class ApiViewModel{
    let apiHandlerModel = ApiHandlerModel.instance
    
    func getData(){
        apiHandlerModel.fetchData(lat: "33.44", lon: "-94.04")
    }
}
