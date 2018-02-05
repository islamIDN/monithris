//
//  LocationManager.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/4/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject {
    let manager = CLLocationManager()
    var didGetLocation: ((Coordinate) -> Void)?
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestLocation()
    }
    
    func getPermission() {
        // to ask permission to the user by showing an alert (the alert message is available on info.plist)
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
       
    }
}




extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinate = Coordinate(location: location)
        if let didGetLocation = didGetLocation {
            didGetLocation(coordinate)
            
        }
    }
}

private extension Coordinate {
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

