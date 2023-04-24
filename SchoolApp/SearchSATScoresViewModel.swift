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
    
    enum TopSchoolsCategory {
        case math
        case reading
        case writing
        case combined
    }
    
    func getTopSchools(selectedSegment: Int, number: Int, score: Int) {
        var category: TopSchoolsCategory

        switch selectedSegment {
        case 0:
            category = .combined
        case 1:
            category = .math
        case 2:
            category = .reading
        default:
            category = .writing
        }

        sortSATData(category: category, score: score)
        getSearchedSchools()
    }

    private func sortSATData(category: TopSchoolsCategory, score: Int) {
        calculatedSchoolsScores = schoolsScores.sorted(by: { score1, score2 in
            switch category {
            case .math:
                return abs(Int(score1.sat_math_avg_score)! - score) < abs(Int(score2.sat_math_avg_score)! - score)
            case .reading:
                return abs(Int(score1.sat_critical_reading_avg_score)! - score) < abs(Int(score2.sat_critical_reading_avg_score)! - score)
            case .writing:
                return abs(Int(score1.sat_writing_avg_score)! - score) < abs(Int(score2.sat_writing_avg_score)! - score)
            case .combined:
                let totalScore1 = abs(Int(score1.sat_math_avg_score)! +  Int(score1.sat_writing_avg_score)! + Int(score1.sat_critical_reading_avg_score)! - score)
                let totalScore2 = abs(Int(score2.sat_math_avg_score)! +  Int(score2.sat_writing_avg_score)! + Int(score2.sat_critical_reading_avg_score)! - score)
                return totalScore1 < totalScore2
            }
        })
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

    func getSchool(index: IndexPath) -> School? {
        return calculatedSchools[index.row]
    }
    
    func getSATScores(index: IndexPath) -> SATData {
        return schoolsScores.first(where: {$0.dbn == calculatedSchools[index.row].dbn}) ?? SATData()
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
            
    //MARK: Cell Methods
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
}
