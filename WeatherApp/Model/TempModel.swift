//
//  TempModel.swift
//  WeatherApp
//
//  Created by comviva on 20/02/22.
//

import Foundation


// singleton class --> Temp Convertion Class
class TempModel {
    
    private init(){}
    static var instance = TempModel()
    
    // converts temp according to selected segment
    func tempConvertion(temp : Double, convertedTo : String) -> String{
        var finalTemp = ""
        switch convertedTo {
        case "k":
            finalTemp = String(format: "%.1f", temp) + " K"
        case "c":
            finalTemp = String(format: "%.1f", (temp - 273.15)) + " ℃"
        case "f":
            finalTemp = String(format: "%.1f", ((temp - 273.15) * (9/5) + 32)) + " ℉"
        default:
            print("Failed convertion!!!")
        }
        return finalTemp
    }
    
}
