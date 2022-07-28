//
//  SchoolsCalculatorViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class SearchSATScoresViewModel {
    var schools: [School]
    var schoolsScores: [SchoolScores]
    var calculatedSchools = [School]()
    var calculatedSchoolsScores = [SchoolScores]()
    var myTotalScore = 0
    var number = 10
    
    init(schools: [School], schoolsScores: [SchoolScores]) {
        self.schools = schools
        self.schoolsScores = schoolsScores
        
    }
    
    func searchTotalScores() {
        let sortedScores = schoolsScores.sorted(by: {abs(Int($0.sat_math_avg_score)! +  Int($0.sat_writing_avg_score)! + Int($0.sat_critical_reading_avg_score)! - myTotalScore) < abs(Int($1.sat_math_avg_score)! +  Int($1.sat_writing_avg_score)! + Int($1.sat_critical_reading_avg_score)! - myTotalScore)})
        
        calculatedSchoolsScores = sortedScores
    }
    
    func searchMathScores() {
        let sortedScores = schoolsScores.sorted(by: {abs(Int($0.sat_math_avg_score)! - myTotalScore) < abs(Int($1.sat_math_avg_score)! - myTotalScore)})
        
        calculatedSchoolsScores = sortedScores
    }
    
    func searchReadingScores() {
        let sortedScores = schoolsScores.sorted(by: {abs(Int($0.sat_critical_reading_avg_score)! - myTotalScore) < abs(Int($1.sat_critical_reading_avg_score)! - myTotalScore)})
        
        calculatedSchoolsScores = sortedScores
    }
    
    func searchWritingScores() {
        let sortedScores = schoolsScores.sorted(by: {abs(Int($0.sat_writing_avg_score)! - myTotalScore) < abs(Int($1.sat_writing_avg_score)! - myTotalScore)})
        
        calculatedSchoolsScores = sortedScores
    }
    
    func getSearchedSchools() {
        var array = [School]()
        
        for i in 0..<calculatedSchoolsScores.count {
            if array.count != number {
                if let school = schools.first(where: {$0.dbn == calculatedSchoolsScores[i].dbn}) {
                    array.append(school)
                }
            } else {
                break
            }
        }
        
        calculatedSchools = array
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        
        if calculatedSchools.count > 0 {
            let school = calculatedSchools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
        } else {
            return (schoolName: "Loading", schoolAddress: "Loading", schoolBoro: "Loading")
        }
    }
}
