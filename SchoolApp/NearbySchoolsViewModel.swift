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

class NearbySchoolsViewModel {
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    var nearbySchools = [School]()
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School]) {
        self.schoolsScores = schoolsSATData
        self.schools = schoolsData
        
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
            let school = schools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
    
    func getNearbySchools(latitude: Double, longitude: Double) {

        for _ in 0..<10 {
            var closest = Double(10000)
            var index = 0
            for j in 0..<schools.count {
                let difference = abs(latitude - Double(schools[j].latitude!)!) + abs(longitude - Double(schools[j].longitude!)!)
                if difference < closest {
                    closest = difference
                    index = j
                }
            }
            nearbySchools.append(schools[index])
            
            schools.remove(at: index)
        }
    }
    
    func findSchool(name: String) -> Int {
        return nearbySchools.firstIndex(where: {$0.school_name == name}) ?? 0
    }
    
    func findSchoolScores(index: Int) -> SchoolScores {
        return schoolsScores.first(where: {$0.dbn == nearbySchools[index].dbn}) ?? SchoolScores(dbn: nearbySchools[index].dbn, num_of_sat_test_takers: "Not Available", sat_critical_reading_avg_score: "0", sat_math_avg_score: "0", sat_writing_avg_score: "0")
    }
}
