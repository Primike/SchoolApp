//
//  SchoolsCalculatorViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

//when no satdata app crashes
class SchoolsCalculatorViewModel {
    var schoolsSATData: [SchoolScores]
    var schoolsData: [School]
    var calculatedSchools = [School]()
    var calculatedSchoolsScores = [SchoolScores]()
    var myTotalScore = 0
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School]) {
        self.schoolsSATData = schoolsSATData
        self.schoolsData = schoolsData
        
    }
    
    func calculateSATList() {
        var array = [SchoolScores]()
        var scoresCopy = schoolsSATData
        
        for _ in 0..<10 {
            var closest = 10000
            var index = 0
            for j in 0..<scoresCopy.count {
                let difference = abs(Int(scoresCopy[j].sat_math_avg_score)! +  Int(scoresCopy[j].sat_writing_avg_score)! + Int(scoresCopy[j].sat_critical_reading_avg_score)! - myTotalScore)
                if difference < closest && scoresCopy[j].dbn != "0" {
                    closest = difference
                    index = j
                }
            }
            
            array.append(scoresCopy[index])
            scoresCopy.remove(at: index)
        }
        calculatedSchoolsScores = array

    }
    
    func getCalculatedSchools() {
        var array = [School]()
        
        for i in calculatedSchoolsScores {
            for j in 0..<schoolsData.count {
                if i.dbn == schoolsData[j].dbn {
                    array.append(schoolsData[j])
                    break
                }
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
