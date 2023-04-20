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
    func getNearbySchools()
    func getSchoolsByMiles()
    func findSchool(name: String) -> Int
    func findSchoolScores(index: Int) -> SATData
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
        
    func getNearbySchools() {
        var array = schools
        nearbySchools = []

        for _ in 0..<numberOfSchools {
            var closest = Double(10000)
            var index = 0
            for j in 0..<array.count {
                let difference = abs(latitude - Double(array[j].latitude!)!) + abs(longitude - Double(array[j].longitude!)!)
                if difference < closest {
                    closest = difference
                    index = j
                }
            }
            nearbySchools.append(array[index])
            array.remove(at: index)
        }
        
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].latitude == nearbySchools[j].latitude && nearbySchools[i].longitude == nearbySchools[j].longitude {
                    nearbySchools[j].longitude = "\(Double(nearbySchools[j].longitude!)! + 0.0007 - 0.00009*Double(j))"
                }
            }
        }
    }
    
    func getSchoolsByMiles() {
        nearbySchools = []
        
        for i in schools {
            let loc = CLLocation(latitude: Double(i.latitude!)!, longitude: Double(i.longitude!)!)
            let distance = loc.distance(from: CLLocation(latitude: latitude, longitude: longitude))
            
            if distance < Double(miles * 1609.34) {
                nearbySchools.append(i)
            }
        }
        
        for i in 0..<nearbySchools.count {
            for j in 0..<nearbySchools.count {
                if i != j && nearbySchools[i].latitude == nearbySchools[j].latitude && nearbySchools[i].longitude == nearbySchools[j].longitude {
                    nearbySchools[j].longitude = "\(Double(nearbySchools[j].longitude!)! + 0.0007 - 0.00009*Double(j))"
                }
            }
        }
    }
    
    func findSchool(name: String) -> Int {
        return nearbySchools.firstIndex(where: {$0.school_name == name}) ?? 0
    }
    
    func findSchoolScores(index: Int) -> SATData {
        return schoolsScores.first(where: {$0.dbn == nearbySchools[index].dbn}) ?? SATData(dbn: nearbySchools[index].dbn, num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0", sat_math_avg_score: "0", sat_writing_avg_score: "0")
    }
}
