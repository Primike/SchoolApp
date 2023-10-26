//
//  NearbySchoolsViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/17/22.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

protocol MapSearchViewModeling {
    var nearbySchools: [SchoolData] { get }
    var currentCoordinates: CLLocationCoordinate2D { get set }
    func getPins() -> [MKAnnotation]
    func validateAddress(address: String, radius: Float, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)
    func filterByCoordinates(coordinates: CLLocationCoordinate2D, miles: Double)
    func filterBySATData(selectedSegment: Int, score: String, count: String)
    func getSchoolData(name: String) -> SchoolData?
}

class MapSearchViewModel: MapSearchViewModeling {
    
    private let schoolsData: [SchoolData]
    var nearbySchools: [SchoolData]
    var currentCoordinates = CLLocationCoordinate2D()
    
    init(schoolsData: [SchoolData]) {
        self.schoolsData = schoolsData
        self.nearbySchools = []
    }
    
    // MARK: - Create Pins
    func getPins() -> [MKAnnotation] {
        var pins = [MKPointAnnotation]()
        
        for data in nearbySchools {
            let school = data.school
            let pin = MKPointAnnotation()
            
            pin.coordinate.longitude = Double(school.longitude!)!
            pin.coordinate.latitude = Double(school.latitude!)!
            pin.title = school.school_name
            pins.append(pin)
        }

        return pins
    }
    
    // MARK: - Validate Address
    func validateAddress(address: String, radius: Float, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        
        if address.isEmpty {
            completion(.success(currentCoordinates))
            return
        }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error == nil else {
                completion(.failure(GeocodingError.geocodingFailed))
                return
            }

            guard let placemark = placemarks?.first,
                  let latitude = placemark.location?.coordinate.latitude,
                  let longitude = placemark.location?.coordinate.longitude,
                  self.isLocatedInNYC(latitude: latitude, longitude: longitude) else {
                completion(.failure(GeocodingError.invalidCoordinates))
                return
            }
            
            completion(.success(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
        }
    }
    
    private func isLocatedInNYC(latitude: Double, longitude: Double) -> Bool {
        let minLat = 40.4, maxLat = 41.01
        let minLong = -74.33, maxLong = -73.55
        
        return latitude >= minLat && latitude <= maxLat && longitude >= minLong && longitude <= maxLong
    }
    
    // MARK: - Filter The Data By Given Parameters
    func filterByCoordinates(coordinates: CLLocationCoordinate2D, miles: Double) {
        nearbySchools = SchoolDataModifier.filterByMiles(schoolsData: schoolsData, coordinates: coordinates, miles: miles)
        nearbySchools = SchoolDataModifier.filterByProximity(nearbySchools: nearbySchools, coordinates: coordinates)
        nearbySchools = SchoolDataModifier.modifyCoordinateDuplicates(nearbySchools: nearbySchools)
    }
        
    func filterBySATData(selectedSegment: Int, score: String, count: String) {
        nearbySchools = SchoolDataModifier.filterBySATData(nearbySchools: nearbySchools, selectedSegment: selectedSegment, score: score, count: count)
    }

    // MARK: - Get SchoolData For Annotation Name
    func getSchoolData(name: String) -> SchoolData? {
        return nearbySchools.first { $0.school.school_name == name }
    }
}
