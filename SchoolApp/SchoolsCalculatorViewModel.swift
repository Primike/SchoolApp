//
//  SchoolsCalculatorViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class SchoolsCalculatorViewModel {
    var schoolsSATData = [SchoolScores]()
    var schoolsData = [School]()
    var myTotalScore: Int
    
    init(schoolsSATData: [SchoolScores], schoolsData: [School], myTotalScore: Int) {
        self.schoolsSATData = schoolsSATData
        self.schoolsData = schoolsData
        self.myTotalScore = myTotalScore
        
        print(myTotalScore)
        calculateSATList()
        getCalculatedSchools()
    }
    
    func calculateSATList() {
        var x = [SchoolScores]()
        
        for _ in 0..<10 {
            var closest = 10000
            var index = 0
            for j in 0..<schoolsSATData.count {
                let difference = abs(Int(schoolsSATData[j].sat_math_avg_score)! +  Int(schoolsSATData[j].sat_writing_avg_score)! + Int(schoolsSATData[j].sat_critical_reading_avg_score)! - myTotalScore)
                if difference < closest && schoolsSATData[j].dbn != "0" {
                    closest = difference
                    index = j
                }
            }
            
            x.append(schoolsSATData[index])
            schoolsSATData.remove(at: index)
        }
        schoolsSATData = x

    }
    
    func getCalculatedSchools() {
        var x = [School]()
        
        for i in schoolsSATData {
            for j in 0..<schoolsData.count {
                if i.dbn == schoolsData[j].dbn {
                    x.append(schoolsData[j])
                    break
                }
            }
        }
        
        schoolsData = x
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        
        if schoolsData.count > 0 {
            let school = schoolsData[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
        } else {
            return (schoolName: "Loading", schoolAddress: "Loading", schoolBoro: "Loading")
        }
    }
    
    func getColor(school: School) -> UIColor {
        switch school.boro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.black
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }
}
