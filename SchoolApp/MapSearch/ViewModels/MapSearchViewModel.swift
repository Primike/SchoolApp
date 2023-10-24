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
}

class MapSearchViewModel {
    var schoolsData: [SchoolData]
    var nearbySchools: [SchoolData]
    var latitude = 0.0
    var longitude = 0.0
    
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
            completion(.success(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
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
    
    func isLocatedInNYC(latitude: Double, longitude: Double) -> Bool {
        let minLat = 40.4, maxLat = 41.01
        let minLong = -74.33, maxLong = -73.55
        
        return latitude >= minLat && latitude <= maxLat && longitude >= minLong && longitude <= maxLong
    }
    
    // MARK: - Filter View Controller Coordinate Methods
    func filterByMiles(coordinates: CLLocationCoordinate2D, miles: Double) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let distanceThreshold = miles * 1609.34 // Convert miles to meters
        
        nearbySchools = schoolsData.filter { data in
            let school = data.school
            let loc = CLLocation(latitude: Double(school.latitude!)!, longitude: Double(school.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latitude, longitude: longitude))
            return distance <= distanceThreshold
        }
        
        filterByProximity(coordinates: coordinates)
    }
    
    private func filterByProximity(coordinates: CLLocationCoordinate2D) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude

        nearbySchools = nearbySchools.sorted { data1, data2 in
            let coordinates1 = data1.school.coordinates
            let coordinates2 = data2.school.coordinates
            
            let distance1 = abs(latitude - coordinates1.latitude) + abs(longitude - coordinates1.longitude)
            let distance2 = abs(latitude - coordinates2.latitude) + abs(longitude - coordinates2.longitude)
            
            return distance1 < distance2
        }
        
        modifyDuplicates()
        print(nearbySchools.count)
    }

    private func modifyDuplicates() {
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].school.latitude == nearbySchools[j].school.latitude && nearbySchools[i].school.longitude == nearbySchools[j].school.longitude {
                    nearbySchools[j].school.longitude = "\(Double(nearbySchools[j].school.longitude!)! + 0.0007 - 0.00009 * Double(j))"
                }
            }
        }
    }
    
    // MARK: - Filter View Controller SAT Data Methods
    enum TopSchoolsCategory {
        case math
        case reading
        case writing
        case combined
    }
        
    func filterBySATData(selectedSegment: Int, score: String, count: String) {
        let sections: [TopSchoolsCategory] = [.combined, .math, .reading, .writing]
        let category = sections[selectedSegment]
        var filtered = [SchoolData]()
        let score = Int(score) ?? 0
        
        for school in nearbySchools {
            switch category {
            case .math:
                if Int(school.sat.sat_math_avg_score) ?? 0 >= score { filtered.append(school) }
            case .reading:
                if Int(school.sat.sat_critical_reading_avg_score) ?? 0 >= score { filtered.append(school) }
            case .writing:
                if Int(school.sat.sat_writing_avg_score) ?? 0 >= score { filtered.append(school) }
            case .combined:
                let math = Int(school.sat.sat_math_avg_score) ?? 0
                let reading = Int(school.sat.sat_critical_reading_avg_score) ?? 0
                let writing = Int(school.sat.sat_writing_avg_score) ?? 0
                
                if math + reading + writing >= score { filtered.append(school) }
            }
        }
        
        if let number = Int(count) { nearbySchools = Array(filtered.prefix(number)) }
    }

    func getSchoolData(name: String) -> SchoolData? {
        return nearbySchools.first { $0.school.school_name == name }
    }
}
