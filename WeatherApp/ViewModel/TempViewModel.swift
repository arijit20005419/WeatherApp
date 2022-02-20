//
//  TempViewModel.swift
//  WeatherApp
//
//  Created by comviva on 20/02/22.
//

import Foundation

class TempViewModel {
    let tempModelHandler = TempModel.instance
    
    // setting temp
    func setTemperatur(temp : Double, convertedTo : String) -> String{
        return tempModelHandler.tempConvertion(temp: temp, convertedTo: convertedTo)
    }
}
