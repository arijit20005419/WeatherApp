//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by comviva on 16/02/22.
//

import Foundation

class LocationViewModel{
    
    let locationModel = LocationModel.instance
    var coord : [String:String] = [:]
    var addressOfUser = ""
    
    func startTrackingNow() async throws-> Bool{
        if locationModel.startTracking(){
            do {
               try await locationModel.getCurrentAddr()
            } catch{
                throw error
            }
            coord["lat"] = String(locationModel.currentLocation?.coordinate.latitude ?? 0.0)
            coord["lon"] = String(locationModel.currentLocation?.coordinate.longitude ?? 0.0)
            addressOfUser = locationModel.address
            
            
            print("Lat : \(coord["lat"])")
            print("Lat : \(coord["lon"])")
            print("Addr : \(addressOfUser)")
            return true
        }
        return false
    }
    
}
