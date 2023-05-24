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
    var schools: [School] { get set }
    var schoolsScores: [SATData] { get set }
    var nearbySchools: [School] { get set }
    var latitude: Double { get set }
    var longitude: Double { get set }
    var miles: Double { get set }
    var numberOfSchools: Int { get set }
    func addressSearch()
    func getSchoolsByMiles()
    func getSchool(name: String) -> Int
    func getSATScores(index: Int) -> SATData
}

class MapSearchViewModel: MapSearchViewModeling {
    var schools = [School]()
    var schoolsScores = [SATData]()
    var nearbySchools = [School]()
    var latitude = 0.0
    var longitude = 0.0
    var miles = 0.0
    var numberOfSchools = 0
    
    init(schools: [School], schoolsScores: [SATData]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
    }
    
    func validateInput(addressText: String, radiusText: String) throws {
        guard !addressText.isEmpty else {
            throw InputError.emptyAddressText
        }
        
        guard !radiusText.isEmpty else {
            throw InputError.emptyRadiusText
        }
        
        guard let radius = Int(radiusText), radius < schools.count else {
            throw InputError.outOfBounds(schools.count)
        }
    }

    func validateAddress(addressText: String) throws {
        
    }
    
    func getSchoolsByMiles() {
        nearbySchools = []
        
        let distanceThreshold = miles * 1609.34 // Convert miles to meters
        
        // Filter schools within the specified distance
        nearbySchools = schools.filter { school in
            let loc = CLLocation(latitude: Double(school.latitude!)!, longitude: Double(school.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latitude, longitude: longitude))
            return distance < distanceThreshold
        }
        
        removeDuplicates()
    }

    func addressSearch() {
        nearbySchools = []

        // Sort the array by distance and take the first 'numberOfSchools' elements
        let sortedSchools = schools.sorted { school1, school2 in
            let distance1 = abs(latitude - Double(school1.latitude!)!) + abs(longitude - Double(school1.longitude!)!)
            let distance2 = abs(latitude - Double(school2.latitude!)!) + abs(longitude - Double(school2.longitude!)!)
            return distance1 < distance2
        }
        
        nearbySchools = Array(sortedSchools.prefix(numberOfSchools))
        
        removeDuplicates()
    }

    func searchMap(placeMark: CLPlacemark, radius: Double) {
        let latituded = placeMark.location?.coordinate.latitude ?? 0.0
        let longituded = placeMark.location?.coordinate.longitude ?? 0.0
        
        let sortedSchools = schools.sorted { school1, school2 in
            let distance1 = abs(latituded - Double(school1.latitude!)!) + abs(longituded - Double(school1.longitude!)!)
            let distance2 = abs(latituded - Double(school2.latitude!)!) + abs(longituded - Double(school2.longitude!)!)
            return distance1 < distance2
        }

        let distanceThreshold = radius * 1609.34 // Convert miles to meters

        nearbySchools = sortedSchools.filter { school in
            let loc = CLLocation(latitude: Double(school.latitude!)!, longitude: Double(school.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latituded, longitude: longituded))
            return distance < distanceThreshold
        }
        
        removeDuplicates()
    }
    
    func removeDuplicates() {
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].latitude == nearbySchools[j].latitude && nearbySchools[i].longitude == nearbySchools[j].longitude {
                    nearbySchools[j].longitude = "\(Double(nearbySchools[j].longitude!)! + 0.0007 - 0.00009 * Double(j))"
                }
            }
        }
    }
    
    //convert address to latitude longitude
    //search nearest schools
    func getSchool(name: String) -> Int {
        return nearbySchools.firstIndex(where: {$0.school_name == name}) ?? 0
    }
    
    func getSATScores(index: Int) -> SATData {
        return schoolsScores.first(where: {$0.dbn == nearbySchools[index].dbn}) ?? SATData(dbn: nearbySchools[index].dbn)
    }
}
