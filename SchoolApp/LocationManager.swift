//
//  LocationManager.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/17/22.
//

import Foundation
import CoreLocation
import MapKit

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    // Method to retrieve the user's location
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        
        // Set the completion closure to the argument passed to this method
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method called when the user's location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method called when location updates are not available
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
}

