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
    var schools = [School]()
    var schoolsScores = [SATData]()
    var nearbySchools = [School]()
    var latitude = 0.0
    var longitude = 0.0
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
    }
    
    func getPins() -> [MKAnnotation] {
        var pins = [MKPointAnnotation]()
        
        for school in nearbySchools {
            let pin = MKPointAnnotation()
            pin.coordinate.longitude = Double(school.longitude!)!
            pin.coordinate.latitude = Double(school.latitude!)!
            pin.title = school.school_name
            
            pins.append(pin)
        }

        return pins
    }
    
    func validateAddress(address: String, radius: Float, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void)  {
        
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
            
//            self.searchMap(placeMark: placemark, radius: Double(radius) ?? 0.0)
            completion(.success(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)))
        }
    }
    
    func isLocatedInNYC(latitude: Double, longitude: Double) -> Bool {
        let minLat = 40.4, maxLat = 41.01
        let minLong = -74.33, maxLong = -73.55
        
        return latitude >= minLat && latitude <= maxLat && longitude >= minLong && longitude <= maxLong
    }
    
    func filterByMiles(coordinates: CLLocationCoordinate2D, miles: Double) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let distanceThreshold = miles * 1609.34 // Convert miles to meters
        
        nearbySchools = schools.filter { school in
            let loc = CLLocation(latitude: Double(school.latitude!)!, longitude: Double(school.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latitude, longitude: longitude))
            return distance <= distanceThreshold
        }
        
        print(nearbySchools.count)
    }
    
    func filterByNumberOfSchools(coordinates: CLLocationCoordinate2D) {
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude

        nearbySchools = nearbySchools.sorted { school1, school2 in
            let distance1 = abs(latitude - Double(school1.latitude!)!) + abs(longitude - Double(school1.longitude!)!)
            let distance2 = abs(latitude - Double(school2.latitude!)!) + abs(longitude - Double(school2.longitude!)!)
            return distance1 < distance2
        }
        
        print(nearbySchools.count)
    }

    func modifyDuplicates() {
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].latitude == nearbySchools[j].latitude && nearbySchools[i].longitude == nearbySchools[j].longitude {
                    nearbySchools[j].longitude = "\(Double(nearbySchools[j].longitude!)! + 0.0007 - 0.00009 * Double(j))"
                }
            }
        }
    }
    
    enum TopSchoolsCategory {
        case math
        case reading
        case writing
        case combined
    }
        
    func filterBySATData(selectedSegment: Int, score: Int, number: Int) {
        let sections: [TopSchoolsCategory] = [.combined, .math, .reading, .writing]
        let category = sections[selectedSegment]
        var filtered = [School]()
        
        for school in nearbySchools {
            let satData = schoolsScores.first { $0.dbn == school.dbn } ?? SATData()
            
            switch category {
            case .math:
                if Int(satData.sat_math_avg_score) ?? 0 >= score { filtered.append(school) }
            case .reading:
                if Int(satData.sat_critical_reading_avg_score) ?? 0 >= score { filtered.append(school) }
            case .writing:
                if Int(satData.sat_writing_avg_score) ?? 0 >= score { filtered.append(school) }
            case .combined:
                let math = Int(satData.sat_math_avg_score) ?? 0
                let reading = Int(satData.sat_critical_reading_avg_score) ?? 0
                let writing = Int(satData.sat_writing_avg_score) ?? 0
                
                if math + reading + writing >= score { filtered.append(school) }
            }
        }
        
        nearbySchools = Array(filtered.prefix(number))
        print(nearbySchools.count)
    }

    func getSchool(name: String) -> Int {
        return nearbySchools.firstIndex(where: {$0.school_name == name}) ?? 0
    }
    
    func getSATScores(index: Int) -> SATData {
        return schoolsScores.first(where: {$0.dbn == nearbySchools[index].dbn}) ?? SATData(dbn: nearbySchools[index].dbn)
    }
}
