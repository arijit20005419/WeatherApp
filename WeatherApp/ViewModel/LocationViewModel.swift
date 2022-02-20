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
    var didLocationFound = false
    
    // Get users exact current location
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
            if !addressOfUser.isEmpty{
                didLocationFound = true
            }
            return true
        }
        return false
    }
    
    
    func getAddressNow(_ addrs : String) async  -> Bool{
        if locationModel.startTracking(){
            do {
                try await locationModel.getCurrentCoordinates(addr: addrs)
            } catch {
                return false
            }
            coord["lat"] = String(locationModel.currentLocation?.coordinate.latitude ?? 0.0)
            coord["lon"] = String(locationModel.currentLocation?.coordinate.longitude ?? 0.0)
            didLocationFound = true
        }
        return true
    }
    
}
