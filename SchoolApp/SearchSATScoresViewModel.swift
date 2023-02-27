//
//  SchoolsCalculatorViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/13/22.
//

import Foundation
import UIKit

class SearchSATScoresViewModel: SchoolCellMethods {
    var schools: [School]
    var schoolsScores: [SATData]
    var calculatedSchools = [School]()
    var calculatedSchoolsScores = [SATData]()
    var myTotalScore = 0
    var number = 10
    
    init(schools: [School], schoolsScores: [SATData]) {
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
        
    //MARK: Cell Methods
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
        let school = calculatedSchools[indexPath.row]
        return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
    
    func getSchoolName(indexPath: IndexPath) -> String {
        return calculatedSchools[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return calculatedSchools[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return calculatedSchools[indexPath.row].boro
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: calculatedSchools[indexPath.row].boro)
    }

    func getColor(schoolBoro: String) -> UIColor {
        switch schoolBoro {
        case "M":
            return UIColor.systemBlue
        case "X":
            return .systemOrange
        case "K":
            return UIColor.systemRed
        case "Q":
            return UIColor.systemPurple
        default:
            return .systemGreen
        }
    }

}
