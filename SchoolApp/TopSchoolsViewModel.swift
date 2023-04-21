//
//  Top10SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

class TopSchoolsViewModel: SchoolCellMethods {
    
    var schools = [School]()
    var schoolsScores = [SATData]()
    var topSchoolsScores = [SATData]()
    var topSchools = [School]()
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

    func getTopSchools(for category: TopSchoolsCategory) {
        topSchoolsScores = []
        topSchools = []
        
        let sortedScores = schoolsScores.sorted(by: { score1, score2 in
            switch category {
            case .math:
                return Int(score1.sat_math_avg_score)! > Int(score2.sat_math_avg_score)!
            case .reading:
                return Int(score1.sat_critical_reading_avg_score)! > Int(score2.sat_critical_reading_avg_score)!
            case .writing:
                return Int(score1.sat_writing_avg_score)! > Int(score2.sat_writing_avg_score)!
            case .combined:
                let totalScore1 = Int(score1.sat_critical_reading_avg_score)! + Int(score1.sat_math_avg_score)! + Int(score1.sat_writing_avg_score)!
                let totalScore2 = Int(score2.sat_critical_reading_avg_score)! + Int(score2.sat_math_avg_score)! + Int(score2.sat_writing_avg_score)!
                return totalScore1 > totalScore2
            }
        })
        
        for i in 0..<sortedScores.count {
            if topSchoolsScores.count != self.number {
                if let school = schools.first(where: {$0.dbn == sortedScores[i].dbn}) {
                    topSchoolsScores.append(sortedScores[i])
                    topSchools.append(school)
                }
            } else {
                break
            }
        }
    }

    //MARK: Cell Methods
    func getSchoolName(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].school_name
    }
    
    func getSchoolAddress(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].location
    }

    func getSchoolBoro(indexPath: IndexPath) -> String {
        return topSchools[indexPath.row].boro
    }
    
    func getSchoolColor(indexPath: IndexPath) -> UIColor {
        return getColor(schoolBoro: topSchools[indexPath.row].boro)
    }
}
