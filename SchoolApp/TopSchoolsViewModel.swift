//
//  Top10SchoolsListViewModel.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 7/10/22.
//

import Foundation
import UIKit

class TopSchoolsViewModel {
    
    var schools = [School]()
    var schoolsScores = [SchoolScores]()
    var topSchoolsScores = [SchoolScores]()
    var topSchools = [School]()
    var number = 10
    
    init(schools: [School], schoolsScores: [SchoolScores]) {
        self.schools = schools
        
        let sortedScores = schoolsScores.sorted(by: { Int($0.sat_critical_reading_avg_score)! + Int($0.sat_math_avg_score)! + Int($0.sat_writing_avg_score)! > Int($1.sat_critical_reading_avg_score)! + Int($1.sat_math_avg_score)! + Int($1.sat_writing_avg_score)!})
        
        self.schoolsScores = sortedScores
    }
    
    func getInfo(for indexPath: IndexPath) -> (schoolName: String, schoolAddress: String, schoolBoro: String) {
            let school = topSchools[indexPath.row]
            return (schoolName: school.school_name, schoolAddress: school.location, schoolBoro: school.boro)
    }
    
    func getTopSchools() {
        topSchoolsScores = []
        topSchools = []
        
        for i in 0..<schoolsScores.count {
            if topSchoolsScores.count != self.number {
                if let school = schools.first(where: {$0.dbn == schoolsScores[i].dbn}) {
                    topSchoolsScores.append(schoolsScores[i])
                    topSchools.append(school)
                }
            } else {
                break
            }
        }
    }
}
