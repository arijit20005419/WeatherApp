//
//  LocationModel.swift
//  WeatherApp
//
//  Created by comviva on 15/02/22.
//

import Foundation
import CoreLocation

class LocationModel : NSObject, CLLocationManagerDelegate{
    
    var lManager : CLLocationManager
    var currentLocation : CLLocation?
    var isPermission : Bool = false
    var address : String = ""
    
    private override init() {
        lManager = CLLocationManager()
        lManager.requestWhenInUseAuthorization()
        lManager.desiredAccuracy = kCLLocationAccuracyKilometer
        super.init()
        lManager.delegate = self
    }
    
    static var instance = LocationModel()
    
    func startTracking() -> Bool{
        
        if isPermission{
            lManager.startUpdatingLocation()
            return true
        }
        return false
    }
    
    func getCurrentAddr() async throws{
        let gc = CLGeocoder()
        if let loc = currentLocation {
            do {
                let placeCode = try await gc.reverseGeocodeLocation(loc)
                if let addr = placeCode.last{
                    self.address = "\(addr.subAdministrativeArea ?? "")"
                    
                }
            } catch {
                throw error
            }
        }
    }
    
    func getCurrentCoordinates(addr : String) async throws{
        let gc = CLGeocoder()
        do {
            let places = try await gc.geocodeAddressString(addr)
            if let place = places.first{
                if let loc = place.location{
                    self.currentLocation = loc
                }
            }
        } catch {
            throw error
        }
        
    }
    
    // from Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last{
            currentLocation = loc
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined, .restricted, .denied:
              isPermission = false
        case .authorizedAlways, .authorizedWhenInUse:
              isPermission = true
        default :
              isPermission = false
        }
    }
    
}
