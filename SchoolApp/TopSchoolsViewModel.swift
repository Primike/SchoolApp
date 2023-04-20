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
    
    func getTopSchools() {
        topSchoolsScores = []
        topSchools = []
        
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_critical_reading_avg_score)! + Int($0.sat_math_avg_score)! + Int($0.sat_writing_avg_score)! > Int($1.sat_critical_reading_avg_score)! + Int($1.sat_math_avg_score)! + Int($1.sat_writing_avg_score)!})
        
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
    
    func getTopMathSchools() {
        topSchoolsScores = []
        topSchools = []
        
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_math_avg_score)! > Int($1.sat_math_avg_score)! })
        
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
    
    func getTopReadingSchools() {
        topSchoolsScores = []
        topSchools = []
        
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_critical_reading_avg_score)! > Int($1.sat_critical_reading_avg_score)! })
        
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
    
    func getTopWritingSchools() {
        topSchoolsScores = []
        topSchools = []
        
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_writing_avg_score)! > Int($1.sat_writing_avg_score)! })
        
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
